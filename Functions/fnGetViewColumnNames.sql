
CREATE FUNCTION [dbo].[fnGetViewColumnNames]
(
	@ViewName varchar(255)
)
RETURNS varchar(max)
AS
BEGIN

SET @ViewName = REPLACE(@ViewName, '[', '')
SET @ViewName = REPLACE(@ViewName, ']', '')
SET @ViewName = REPLACE(@ViewName, 'dbo.', '')
SET @ViewName = REPLACE(@ViewName, 'ud.', '')

DECLARE @ColumnNames varchar(max)
DECLARE @CurrentColumnName varchar(255)

SET @ColumnNames = ''

DECLARE @SchemaName VARCHAR(10)

SET @SchemaName = 'dbo'
IF SYSTEM_USER <> 'sa' BEGIN
	SET @SchemaName = ISNULL((SELECT default_schema_name FROM sys.database_principals WHERE type = 'S' AND NAME = SYSTEM_USER),'dbo')
end


if @SchemaName <> 'dbo' and not exists (select * from  INFORMATION_SCHEMA.columns  where TABLE_SCHEMA = @SchemaName 
	and TABLE_NAME = @ViewName) BEGIN
	set @SchemaName = 'dbo'
END

DECLARE CNcursor cursor
FOR
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.columns
WHERE TABLE_NAME = @ViewName
AND TABLE_SCHEMA = @SchemaName

OPEN CNCursor

FETCH CNCursor INTO @CurrentColumnName

	WHILE @@FETCH_STATUS = 0
	BEGIN

		IF (LEN(@ColumnNames) = 0)
		BEGIN
			SET @ColumnNames = '[' + @CurrentColumnName + ']'
		END
		ELSE
		BEGIN
			SET @ColumnNames = @ColumnNames + ', [' + @CurrentColumnName + ']'
		END

		FETCH CNCursor INTO @CurrentColumnName

	END

CLOSE CNCursor
DEALLOCATE CNCursor

RETURN @ColumnNames

END
