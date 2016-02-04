-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into ParserIdentification
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspParserIdentificationInsert]
(	  @IdentificationString varchar(80)
	, @IdentificationRow int
	, @IdentificationColumn int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkParserIdentification decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT ParserIdentification
(	  IdentificationString
	, IdentificationRow
	, IdentificationColumn
)
VALUES 
(	  @IdentificationString
	, @IdentificationRow
	, @IdentificationColumn

)

SET @pkParserIdentification = SCOPE_IDENTITY()
