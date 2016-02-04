
--[usp_GetAutoFillDataColumns] 17

CREATE PROC [dbo].[usp_GetAutoFillDataColumns]
(
	@DataViewID int
)
AS

DECLARE @SQLExec varchar(max)

	SET @SQLExec = dbo.[fnSQLToQueryColumnList](@DataViewID)
	EXEC(@SQLExec)
