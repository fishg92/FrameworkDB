CREATE PROCEDURE [dbo].[FindUnmergedMemberId]
	@MemberId decimal
as

declare @unMergedId decimal
select @unMergedId = pkCpClient from CPClient where pkCPClient = @MemberId

if @unMergedId is null begin
	;WITH    q AS 
			(
			SELECT  *
			FROM    MergedMembers
			WHERE   fkCPDuplicateMember = @MemberId
			UNION ALL
			SELECT  m.*
			FROM    MergedMembers m
			JOIN    q
			ON      q.fkCPMergeMember = m.fkCPDuplicateMember
			)

	SELECT  @unMergedId = pkCPClient
	FROM    q inner join CPClient on fkCPMergeMember = pkCPClient

end

select @unMergedId