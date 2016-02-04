CREATE PROCEDURE [dbo].[FindUnmergedCaseId]
	@CaseId decimal
as

declare @unMergedId decimal
select @unMergedId = pkCpClientCase from CPClientCase where pkCPClientCase = @CaseId

if @unMergedId is null begin
	;WITH    q AS 
			(
			SELECT  *
			FROM    MergedCase
			WHERE   fkCPClientCaseDuplicate = @CaseId
			UNION ALL
			SELECT  m.*
			FROM    MergedCase m
			JOIN    q
			ON      q.fkCPMergeCase = m.fkCPClientCaseDuplicate
			)

	SELECT  @unMergedId = pkCPClientCase
	FROM    q inner join cpClientCase on fkCPMergeCase = pkCPClientCase

end

select @unMergedId