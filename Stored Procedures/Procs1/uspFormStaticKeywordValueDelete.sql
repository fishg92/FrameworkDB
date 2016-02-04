-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from FormStaticKeywordValue
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormStaticKeywordValueDelete]
(	@pkFormStaticKeywordValue int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	FormStaticKeywordValue
WHERE 	pkFormStaticKeywordValue = @pkFormStaticKeywordValue
