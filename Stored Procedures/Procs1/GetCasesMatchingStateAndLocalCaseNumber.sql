
CREATE proc [dbo].[GetCasesMatchingStateAndLocalCaseNumber]
(
	@StateCaseNumber varchar(100)
	,@LocalCaseNumber varchar(100)
)

as
select * from cpClientCase
where  StateCaseNumber  = @StateCaseNumber 
and LocalCaseNumber = @LocalCaseNumber
