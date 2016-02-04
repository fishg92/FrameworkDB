-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into ParserKeyValue
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspParserKeyValueInsert]
(	  @fkParserIdentification decimal(10, 0)
	, @KeyValueRow int
	, @KeyValueColumn int
	, @KeyValueLength int
	, @KeyValueSearchName varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkParserKeyValue decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT ParserKeyValue
(	  fkParserIdentification
	, KeyValueRow
	, KeyValueColumn
	, KeyValueLength
	, KeyValueSearchName
)
VALUES 
(	  @fkParserIdentification
	, @KeyValueRow
	, @KeyValueColumn
	, @KeyValueLength
	, @KeyValueSearchName

)

SET @pkParserKeyValue = SCOPE_IDENTITY()
