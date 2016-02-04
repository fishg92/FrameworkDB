-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormJoinStaticKeywordNameFormName
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormJoinStaticKeywordNameFormNameInsert]
(	  @fkFormName decimal(10, 0)
	, @fkFormStaticKeywordName decimal(10, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormJoinStaticKeywordNameFormName decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormJoinStaticKeywordNameFormName
(	  pkFormJoinStaticKeywordNameFormName
	, fkFormName
	, fkFormStaticKeywordName
)
VALUES 
(	  @pkFormJoinStaticKeywordNameFormName
	, @fkFormName
	, @fkFormStaticKeywordName

)

SET @pkFormJoinStaticKeywordNameFormName = SCOPE_IDENTITY()
