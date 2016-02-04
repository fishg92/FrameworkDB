-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormStaticKeywordValue
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormStaticKeywordValueInsert]
(	  @StaticKeywordValue varchar(100)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormStaticKeywordValue decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormStaticKeywordValue
(	  StaticKeywordValue
)
VALUES 
(	  @StaticKeywordValue

)

SET @pkFormStaticKeywordValue = SCOPE_IDENTITY()
