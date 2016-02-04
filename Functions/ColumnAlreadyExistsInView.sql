
CREATE FUNCTION [dbo].[ColumnAlreadyExistsInView](@ViewName NVARCHAR(128),@ColumnName NVARCHAR(128))
RETURNS INTEGER--Returns 0 if column does not exist. Returns 1 if column exists.
AS
BEGIN
-- FORMAT TO BE A VALID VIEW NAME (Remove [ and dbo.)
SET @ViewName = REPLACE(@ViewName, '[', '')
SET @ViewName = REPLACE(@ViewName, ']', '')
SET @ViewName = REPLACE(@ViewName, 'dbo.', '')
SET @ViewName = REPLACE(@ViewName, 'ud.', '')

DECLARE @SchemaName VARCHAR(10)
DECLARE @ReturnValue int

SET @SchemaName = 'dbo'
IF SYSTEM_USER <> 'sa' BEGIN
	SET @SchemaName = ISNULL((SELECT default_schema_name FROM sys.database_principals WHERE type = 'S' AND NAME = SYSTEM_USER),'dbo')
end


if @SchemaName <> 'dbo' and not exists (select * from  INFORMATION_SCHEMA.columns  where TABLE_SCHEMA = @SchemaName 
	and TABLE_NAME = @ViewName) BEGIN
	set @SchemaName = 'dbo'
END

--See if the Table already contains the column.
IF EXISTS
	(SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.columns
		WHERE TABLE_NAME = @ViewName
		AND TABLE_SCHEMA = @SchemaName
		AND COLUMN_NAME = @ColumnName) BEGIN
	set @ReturnValue = 1
END ELSE BEGIN
	set @ReturnValue = 0
END
/*
(SELECT * FROM SysObjects O INNER JOIN SysColumns C ON O.ID=C.ID
WHERE ObjectProperty(O.ID,'IsView')=1
	AND O.Name=@ViewName
	AND C.Name=@ColumnName)
	AND O.TABLE_SCHEMA = @SchemaName
RETURN 1
--Table does not contain the column.
RETURN 0
*/
RETURN @ReturnValue
END
