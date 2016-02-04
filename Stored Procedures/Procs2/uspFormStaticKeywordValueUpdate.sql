-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormStaticKeywordValue
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormStaticKeywordValueUpdate]
(	  @pkFormStaticKeywordValue int
	, @StaticKeywordValue varchar(100) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormStaticKeywordValue
SET	StaticKeywordValue = ISNULL(@StaticKeywordValue, StaticKeywordValue)
WHERE 	pkFormStaticKeywordValue = @pkFormStaticKeywordValue
