
----------------------------------------------------------------------------
-- Select a single record from ParserIdentification
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspParserIdentificationSelect]
(	@pkParserIdentification decimal(10, 0) = NULL,
	@IdentificationString varchar(80) = NULL,
	@IdentificationRow int = NULL,
	@IdentificationColumn int = NULL	
)
AS

SELECT	pkParserIdentification,
	IdentificationString,
	IdentificationRow,
	IdentificationColumn
FROM	ParserIdentification
WHERE 	(@pkParserIdentification IS NULL OR pkParserIdentification = @pkParserIdentification)
 AND 	(@IdentificationString IS NULL OR IdentificationString LIKE @IdentificationString + '%')
 AND 	(@IdentificationRow IS NULL OR IdentificationRow = @IdentificationRow)
 AND 	(@IdentificationColumn IS NULL OR IdentificationColumn = @IdentificationColumn)


