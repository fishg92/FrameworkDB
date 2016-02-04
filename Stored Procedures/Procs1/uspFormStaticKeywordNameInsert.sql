



----------------------------------------------------------------------------
-- Insert a single record into FormStaticKeywordName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormStaticKeywordNameInsert]
(	  @fkKeywordType varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @pkFormStaticKeywordName decimal(10, 0) = NULL OUTPUT 
)
AS

   Declare @LUPMachine varchar(15)
	select @LUPMachine = NULL

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormStaticKeywordName
(	  
	fkKeywordType
)
VALUES 
(	  
	UPPER(@fkKeywordType)
)

SET @pkFormStaticKeywordName = SCOPE_IDENTITY()
