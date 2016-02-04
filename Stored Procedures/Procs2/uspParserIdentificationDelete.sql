-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from ParserIdentification
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspParserIdentificationDelete]
(	@pkParserIdentification int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	ParserIdentification
WHERE 	pkParserIdentification = @pkParserIdentification
