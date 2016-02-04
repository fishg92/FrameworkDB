CREATE proc [dbo].[DeleteCase]
	@pkCPClientCase decimal
	,@fkApplicationUser decimal
as

begin tran

delete ApplicationUserFavoriteCase
where fkCPClientCase = @pkCPClientCase

delete CPCaseActivity
where fkCPClientCase = @pkCPClientCase

delete DuplicateCases
where fkCPClientCaseMain = @pkCPClientCase
or fkCPClientCaseDuplicate = @pkCPClientCase

--Task section
--Delete tasks and associated records if the tasks are associated with the case

--Since we only know the case ID, put the Task primary keys
--into a list so that data can be deleted in the proper order
declare @task table(pkTask decimal)

insert @task(pkTask)
select fkTask 
from JoinTaskCPClientCase
where fkCPClientCase = @pkCPClientCase

delete JoinTaskCPClientFormName
from JoinTaskCPClientFormName f
join JoinTaskCPClient c
	on f.fkJoinTaskCPClient = c.pkJoinTaskCPClient
join @task t
	on c.fkTask = t.pkTask

delete JoinTaskCPClient
from JoinTaskCPClient c
join @task t
	on c.fkTask = t.pkTask

delete JoinTaskDocument
from JoinTaskDocument d
join @task t
	on d.fkTask = t.pkTask

delete TaskAssignment
from TaskAssignment a
join @task t
	on a.fkTask = t.pkTask

delete JoinTaskCPClientCase
where fkCPClientCase = @pkCPClientCase

delete Task
from Task ta
join @task t
	on ta.pkTask = t.pkTask

--ExternalTaskMetaData section

declare @exmd table (pkExternalTaskMetaData decimal)

insert @exmd (pkExternalTaskMetaData)
select fkExternalTaskMetaData
from JoinExternalTaskMetaDataCPClientCase
where fkCPClientCase = @pkCPClientCase

delete JoinExternalTaskMetaDataApplicationUser
from JoinExternalTaskMetaDataApplicationUser au
join @exmd ex
	on au.fkExternalTaskMetaData = ex.pkExternalTaskMetaData

delete JoinExternalTaskMetaDataCPClient
from JoinExternalTaskMetaDataCPClient c
join @exmd ex
	on c.fkExternalTaskMetaData = ex.pkExternalTaskMetaData

delete JoinExternalTaskMetaDataCPClientCase
where fkCPClientCase = @pkCPClientCase

delete ExternalTaskMetaData
from ExternalTaskMetaData md
join @exmd ex
	on md.pkExternalTaskMetaData = ex.pkExternalTaskMetaData

--FormQuickListFormName section
declare @ql table (pkFormQuickListFormName decimal)

insert @ql(pkFormQuickListFormName)
select pkFormQuickListFormName
from FormQuickListFormName
where fkCPClientCase = @pkCPClientCase

--A list of folders containing quick list items about to be deleted
--At the end, delete folders that are empty
declare @folders table(pkFormQuickListFolder decimal)

insert @folders(pkFormQuickListFolder)
select j.fkFormQuickListFolder
from FormJoinQuickListFormFolderQuickListFormName j
join @ql ql
	on j.fkFormQuickListFormName = ql.pkFormQuickListFormName

delete FormJoinQuickListFormFolderQuickListFormName
from FormJoinQuickListFormFolderQuickListFormName j
join @ql ql
	on j.fkFormQuickListFormName = ql.pkFormQuickListFormName

delete FormQuickListAdditionalStamp
from FormQuickListAdditionalStamp s
join @ql ql
	on s.fkFormQuickListFormName = ql.pkFormQuickListFormName

delete FormQuickListAutoFillValue
from FormQuickListAutoFillValue a
join @ql ql
	on a.fkFormQuickListFormName = ql.pkFormQuickListFormName

delete FormJoinQuickListFormNameAnnotationAnnotationValue
from FormJoinQuickListFormNameAnnotationAnnotationValue av
join @ql ql
	on av.fkQuickListFormName = ql.pkFormQuickListFormName

delete FormPeerReviewNote
from FormPeerReviewNote n
join @ql ql
	on n.fkQuickListFormName = ql.pkFormQuickListFormName

delete FormQuickListFormName
from FormQuickListFormName fn
join @ql ql
	on fn.pkFormQuickListFormName = ql.pkFormQuickListFormName

--Delete quick list folders that were emptied by this process
delete FormQuickListFolder
from FormQuickListFolder qlf
join @folders f
	on f.pkFormQuickListFolder = qlf.pkFormQuickListFolder
left join FormJoinQuickListFormFolderQuickListFormName j
	on j.fkFormQuickListFolder = qlf.pkFormQuickListFolder
where j.pkFormJoinQuickListFormFolderQuickListFormName is null

delete FormQuickListFolderName
from FormQuickListFolderName n
left join FormQuickListFolder f
	on n.pkFormQuickListFolderName = f.fkFormQuickListFolderName
where f.pkFormQuickListFolder is null

--Delete client case joins
delete CPJoinClientClientCase
where fkCPClientCase = @pkCPClientCase

--Record the deletion
insert DeletedCase
	(
		fkCPClientCase
		,StateCaseNumber
		,LocalCaseNumber
		,fkProgramType
		,fkApplicationUser
	)
select @pkCPClientCase
		,StateCaseNumber
		,LocalCaseNumber
		,fkCPRefClientCaseProgramType
		,@fkApplicationUser
from CPClientCase
where pkCPClientCase = @pkCPClientCase

--Finally, delete the case
delete CPClientCase
where pkCPClientCase = @pkCPClientCase

commit