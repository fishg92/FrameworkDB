CREATE PROC [dbo].[usp_automatedtest_DeleteByStateCaseNumber]
	@StateCaseNumber varchar(20)
AS
BEGIN

	DECLARE @pkCPClientCase as decimal
	SET @pkCPClientCase = (SELECT Top 1 pkCPClientCase FROM CPClientCase WHERE StateCaseNumber = @StateCaseNumber)

	DELETE FROM cpjoinclientclientcase
	WHERE fkCPClientCase = @pkCPClientCase

	DELETE FROM CPClientCase
	WHERE StateCaseNumber = @StateCaseNumber

END