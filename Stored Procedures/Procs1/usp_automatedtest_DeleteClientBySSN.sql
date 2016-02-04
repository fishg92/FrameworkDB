CREATE PROC [dbo].[usp_automatedtest_DeleteClientBySSN]
	@SSN char(10)
AS
BEGIN

	DECLARE @NorthwoodsNumber varchar(50)
	SET @NorthwoodsNumber = (SELECT Top 1 NorthwoodsNumber FROM CPClient WHERE SSN = @SSN)

	EXEC [dbo].[usp_automatedtest_DeleteClient] @NorthwoodsNumber

END
