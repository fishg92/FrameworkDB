﻿-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from ParserKeyValue
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspParserKeyValueDelete]
(	@pkParserKeyValue int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	ParserKeyValue
WHERE 	pkParserKeyValue = @pkParserKeyValue
