-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from FormJoinFormStaticKeywordNameFormStaticKeywordValue
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormJoinFormStaticKeywordNameFormStaticKeywordValueDelete]
(	@pkFormJoinFormStaticKeywordNameFormStaticKeywordValue int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	FormJoinFormStaticKeywordNameFormStaticKeywordValue
WHERE 	pkFormJoinFormStaticKeywordNameFormStaticKeywordValue = @pkFormJoinFormStaticKeywordNameFormStaticKeywordValue
