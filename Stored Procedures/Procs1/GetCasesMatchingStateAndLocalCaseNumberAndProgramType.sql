

CREATE proc [dbo].[GetCasesMatchingStateAndLocalCaseNumberAndProgramType]
(
	@StateCaseNumber varchar(100),
	@LocalCaseNumber varchar(100),
	@fkProgramType decimal
)

as

select * from cpClientCase
where  StateCaseNumber  = @StateCaseNumber 
and LocalCaseNumber = @LocalCaseNumber
and fkCPRefClientCaseProgramType = @fkProgramType
