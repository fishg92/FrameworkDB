-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in ParserKeyValue
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspParserKeyValueUpdate]
(	  @pkParserKeyValue decimal(10, 0)
	, @fkParserIdentification decimal(10, 0) = NULL
	, @KeyValueRow int = NULL
	, @KeyValueColumn int = NULL
	, @KeyValueLength int = NULL
	, @KeyValueSearchName varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	ParserKeyValue
SET	fkParserIdentification = ISNULL(@fkParserIdentification, fkParserIdentification),
	KeyValueRow = ISNULL(@KeyValueRow, KeyValueRow),
	KeyValueColumn = ISNULL(@KeyValueColumn, KeyValueColumn),
	KeyValueLength = ISNULL(@KeyValueLength, KeyValueLength),
	KeyValueSearchName = ISNULL(@KeyValueSearchName, KeyValueSearchName)
WHERE 	pkParserKeyValue = @pkParserKeyValue
