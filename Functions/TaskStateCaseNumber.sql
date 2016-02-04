CREATE function [dbo].[TaskStateCaseNumber]
	(
		@pkTask decimal
	)
returns varchar(1000)
as
begin

declare @CaseNumber varchar(1000)
  ,@pkCPClient decimal
  ,@pkCPClientCase decimal
  ,@CaseCount int
  ,@IsCaseTask bit
 
set @CaseNumber = ''
set @IsCaseTask = 0

select @IsCaseTask = 1
from JoinTaskCPClientCase
join CPClientCase
 on JoinTaskCPClientCase.fkCPClientCase = CPClientCase.pkCPClientCase
where JoinTaskCPClientCase.fkTask = @pkTask

select @CaseCount = count(*)
from JoinTaskCPClientCase
join CPClientCase
 on JoinTaskCPClientCase.fkCPClientCase = CPClientCase.pkCPClientCase
where JoinTaskCPClientCase.fkTask = @pkTask
and CPClientCase.CaseStatus = 1

if @CaseCount = 1
 begin
 select @CaseNumber = isnull(StateCaseNumber,'')
 from CPClientCase
 where pkCPClientCase = (select fkCPClientCase
	   from JoinTaskCPClientCase
	   where fkTask = @pkTask)
 and CPClientCase.CaseStatus = 1
 end

set @CaseNumber = isnull(@CaseNumber,'')

if @CaseNumber = '' and @IsCaseTask = 0
 begin
 select @CaseCount = count(*)
 from JoinTaskCPClient
 join CPClient
  on JoinTaskCPClient.fkCPClient = CPClient.pkCPClient
 join CPJoinClientClientCase
  on CPJoinClientClientCase.fkCPClient = CPClient.pkCPClient
 join CPClientCase
  on CPClientCase.pkCPClientCase = CPJoinClientClientCase.fkCPClientCase
 where JoinTaskCPClient.fkTask = @pkTask
 and CPClientCase.CaseStatus = 1

 if @CaseCount = 1
  begin

  select @CaseNumber = StateCaseNumber
  from JoinTaskCPClient
  join CPClient
   on JoinTaskCPClient.fkCPClient = CPClient.pkCPClient
  join CPJoinClientClientCase
   on CPJoinClientClientCase.fkCPClient = CPClient.pkCPClient
  join CPClientCase
   on CPClientCase.pkCPClientCase = CPJoinClientClientCase.fkCPClientCase
  where JoinTaskCPClient.fkTask = @pkTask
  and CPClientCase.CaseStatus = 1
  end
 end
 
if @CaseCount > 1
 --set @CaseNumber = '(Multiple)'
 begin
 set @CaseNumber = ''
 
 declare crCaseNumber cursor local for 
 select distinct CPClientCase.StateCaseNumber
 from JoinTaskCPClient
 join CPClient
  on JoinTaskCPClient.fkCPClient = CPClient.pkCPClient
 join CPJoinClientClientCase
  on CPJoinClientClientCase.fkCPClient = CPClient.pkCPClient
 join CPClientCase
  on CPClientCase.pkCPClientCase = CPJoinClientClientCase.fkCPClientCase
 where JoinTaskCPClient.fkTask = @pkTask
 and CPClientCase.CaseStatus = 1

 declare @tempCase varchar(20)
 
 open crCaseNumber
 fetch next from crCaseNumber into @tempCase
 while @@fetch_status = 0
  begin
  if @CaseNumber <> ''
   set @CaseNumber = @CaseNumber + ', '
  set @CaseNumber = @CaseNumber + @tempCase
  fetch next from crCaseNumber into @tempCase
  end
 close crCaseNumber
 deallocate crCaseNumber
 end

return @CaseNumber
end