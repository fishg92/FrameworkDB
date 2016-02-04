CREATE PROC [dbo].[MergeDuplicateCase]
(	   @pkCPClientCaseMaster decimal (18,0)
	  ,@pkCPClientCaseDuplicate decimal (18,0)
	  ,@DuplicateLocalCaseNumber varchar (20)
	  ,@StateCaseNumber varchar (20)
	  ,@LUPUser varchar (100)
)
AS

Declare @CaseInfoWasAltered bit 
set @CaseInfoWasAltered = 0

--Update Case Members to point to Master

Declare @CurrentMembers as table (
fkcpclient  decimal (18,0) )

insert into @CurrentMembers (fkcpclient)
select fkCPClient from CPJoinClientClientCase where fkCPClientCase = @pkCPClientCaseMaster

update dbo.CPJoinClientClientCase
set fkCPClientCase = @pkCPClientCaseMaster
,PrimaryParticipantOnCase = 0
where fkCPClientCase = @pkCPClientCaseDuplicate
and fkcpclient not in (select fkcpclient from @CurrentMembers)

delete from dbo.CPJoinClientClientCase
where fkCPClientCase = @pkCPClientCaseDuplicate

If @@ROWCOUNT > 0 
	set @CaseInfoWasAltered = 1

--Update Case Activity to Point to Master
update dbo.CPCaseActivity
set fkCPClientCase = @pkCPClientCaseMaster
where fkCPClientCase = @pkCPClientCaseDuplicate

If @@ROWCOUNT > 0 
	set @CaseInfoWasAltered = 1

Insert into dbo.MergedCase (fkCPClientCaseDuplicate, fkCPMergeCase)
VALUES (@pkCPClientCaseDuplicate,@pkCPClientCaseMaster)
Declare @Description As varchar (200)


set @Description = 'Local Case Number ''' + @DuplicateLocalCaseNumber + ' '' merged into State Case Number ' + @StateCaseNumber
Declare @pkCaseActivityType as decimal (18,0)
set @pkCaseActivityType = (select pkCPCaseActivityType from CPCaseActivityType where Description = 'Case Merged')
Declare @date As datetime 
set @date = getdate()
If @pkCaseActivityType is not null
	exec dbo.uspCPCaseActivityInsert @pkCaseActivityType, @pkCPClientCaseMaster, @Description, 0, null, @LUPUser , null,null, null

update dbo.JoinTaskCPClientCase
set	fkCPClientCase = @pkCPClientCaseMaster
from JoinTaskCPClientCase j1
where	fkCPClientCase = @pkCPClientCaseDuplicate
and not exists (select * from JoinTaskCPClientCase j2
				where fkTask = j1.fkTask
				and	fkCPClientCase = @pkCPClientCaseMaster)

delete	JoinTaskCPClientCase
where fkCPClientCase = @pkCPClientCaseDuplicate

DELETE FROM dbo.CPClientCase
where pkCPClientCase = @pkCPClientCaseDuplicate