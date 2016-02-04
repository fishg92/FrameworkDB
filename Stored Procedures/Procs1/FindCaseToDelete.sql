CREATE proc FindCaseToDelete
	@ProgramType varchar(50)
	,@StateCaseNumber varchar(20)
	,@LocalCaseNumber varchar(20)
	,@pkCPClientCase decimal output
as


/****************************************************************
	Find the pkCPClientCase for a case that is to be deleted.

	Special @pkCPClientCase values:
	0 - No case found
	-1 - Multiple cases exist with the values provided
***************************************************************/

declare @caseCount int

set @caseCount = 
	(
		select count(*)
		from CPClientCase cc
		join ProgramType pt
			on cc.fkCPRefClientCaseProgramType = pt.pkProgramType
		where cc.StateCaseNumber = @StateCaseNumber
		and cc.LocalCaseNumber = @LocalCaseNumber
		and pt.ProgramType = @ProgramType
	)

if @caseCount = 0
begin
	set @pkCPClientCase = 0
	return
end

if @caseCount > 1
begin
	set @pkCPClientCase = -1
	return
end

select @pkCPClientCase = cc.pkCPClientCase
from CPClientCase cc
join ProgramType pt
	on cc.fkCPRefClientCaseProgramType = pt.pkProgramType
where cc.StateCaseNumber = @StateCaseNumber
and cc.LocalCaseNumber = @LocalCaseNumber
and pt.ProgramType = @ProgramType

set @pkCPClientCase = ISNULL(@pkCPClientCase,0)


