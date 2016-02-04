
----------------------------------------------------------------------------
-- Select a single record from ParserKeyValue
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspParserKeyValueSelect]
(	@pkParserKeyValue decimal(10, 0) = NULL,
	@fkParserIdentification decimal(10, 0) = NULL,
	@KeyValueRow int = NULL,
	@KeyValueColumn int = NULL,
	@KeyValueLength int = NULL,
	@KeyValueSearchName varchar(50) = NULL
    
)
AS

SELECT	pkParserKeyValue,
	fkParserIdentification,
	KeyValueRow,
	KeyValueColumn,
	KeyValueLength,
	KeyValueSearchName
FROM	ParserKeyValue
WHERE 	(@pkParserKeyValue IS NULL OR pkParserKeyValue = @pkParserKeyValue)
 AND 	(@fkParserIdentification IS NULL OR fkParserIdentification = @fkParserIdentification)
 AND 	(@KeyValueRow IS NULL OR KeyValueRow = @KeyValueRow)
 AND 	(@KeyValueColumn IS NULL OR KeyValueColumn = @KeyValueColumn)
 AND 	(@KeyValueLength IS NULL OR KeyValueLength = @KeyValueLength)
 AND 	(@KeyValueSearchName IS NULL OR KeyValueSearchName LIKE @KeyValueSearchName + '%')


