-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in ParserIdentification
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspParserIdentificationUpdate]
(	  @pkParserIdentification decimal(10, 0)
	, @IdentificationString varchar(80) = NULL
	, @IdentificationRow int = NULL
	, @IdentificationColumn int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	ParserIdentification
SET	IdentificationString = ISNULL(@IdentificationString, IdentificationString),
	IdentificationRow = ISNULL(@IdentificationRow, IdentificationRow),
	IdentificationColumn = ISNULL(@IdentificationColumn, IdentificationColumn)
WHERE 	pkParserIdentification = @pkParserIdentification
