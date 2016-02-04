


--exec [GetWarningsForDeactivatedUsers] 1
CREATE    PROC [dbo].[GetWarningsForDeactivatedUsers] @pkApplicationUser decimal(18,0)
As

--Tasks
select 
Description as [Tasks] 
from TaskAssignment (nolock)
where @pkApplicationUser = fkApplicationUserAssignedTo
and fkrefTaskAssignmentStatus not in (3,4)
order by Description

--Clients
select  
ProgramType as [Program Type]
,StateCaseNumber as [State Case Number]
,LocalCaseNumber as [Local Case Number]
from CPClientCase (nolock)
inner join ProgramType on ProgramType.pkProgramType = CPClientCase.fkCPRefClientCaseProgramType
where @pkApplicationUser = fkApplicationUser 
order by ProgramType,StateCaseNumber , Localcasenumber

--Forms
select QuickListFormName as [Favorites] 
from [dbo].[FormQuickListFormName] (nolock)
where fkFormUser = @pkApplicationUser
and Inactive = 0
order by QuickListFormName


select [Pool] = r.Name + ' - Pool Manager'    
from [dbo].[JoinRecipientPoolManager] j
inner join [dbo].[RecipientPool] r on r.pkRecipientPool = j.fkRecipientPool 
where fkApplicationUser = @pkApplicationUser

union

select [Pool] = r.Name + ' - Pool Member'       
from [dbo].[JoinRecipientPoolMember] j
inner join [dbo].[RecipientPool] r on r.pkRecipientPool = j.fkRecipientPool 
where fkApplicationUser = @pkApplicationUser

