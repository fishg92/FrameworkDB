-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormJoinFormStaticKeywordNameFormStaticKeywordValue
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormJoinFormStaticKeywordNameFormStaticKeywordValueInsert]
(	  @fkFormStaticKeywordName decimal(10, 0)
	, @fkFormStaticKeywordValue decimal(10, 0)
	, @fkFormName decimal(10, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormJoinFormStaticKeywordNameFormStaticKeywordValue decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormJoinFormStaticKeywordNameFormStaticKeywordValue
(	  fkFormStaticKeywordName
	, fkFormStaticKeywordValue
	, fkFormName
)
VALUES 
(	  @fkFormStaticKeywordName
	, @fkFormStaticKeywordValue
	, @fkFormName

)

SET @pkFormJoinFormStaticKeywordNameFormStaticKeywordValue = SCOPE_IDENTITY()
