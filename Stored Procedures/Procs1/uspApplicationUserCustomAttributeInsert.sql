----------------------------------------------------------------------------
-- Insert a single record into ApplicationUserCustomAttribute
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspApplicationUserCustomAttributeInsert]
(	  @fkApplicationUser decimal(18, 0)
	, @ItemKey varchar(200)
	, @ItemValue varchar(300)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkApplicationUserCustomAttribute decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT ApplicationUserCustomAttribute
(	  fkApplicationUser
	, ItemKey
	, ItemValue
)
VALUES 
(	  @fkApplicationUser
	, @ItemKey
	, @ItemValue

)

SET @pkApplicationUserCustomAttribute = SCOPE_IDENTITY()
