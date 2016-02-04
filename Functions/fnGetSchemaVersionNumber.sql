CREATE FUNCTION [dbo].[fnGetSchemaVersionNumber] ()
RETURNS varchar(50)
AS
BEGIN
	RETURN '6.4.50.1'
END