
CREATE PROCEDURE [dbo].[uspCPGetCompassClientInformation]
(
	  @ColumnName varchar(100)
	, @Value varchar(MAX)
	, @OrderByColumnName varchar(100)
)
AS

	DECLARE @SQL varchar(1000)

	SET @SQL = 'SELECT * FROM [dbo].[CompassClientInformation] WHERE [' + @ColumnName + '] LIKE ''' + @Value + '%'' ORDER BY [' + @OrderByColumnName + ']'

	EXEC (@SQL)
