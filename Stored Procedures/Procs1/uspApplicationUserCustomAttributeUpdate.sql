----------------------------------------------------------------------------
-- Update a single record in ApplicationUserCustomAttribute
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspApplicationUserCustomAttributeUpdate]
(	  @pkApplicationUserCustomAttribute decimal(18, 0)
	, @fkApplicationUser decimal(18, 0) = NULL
	, @ItemKey varchar(200) = NULL
	, @ItemValue varchar(300) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	ApplicationUserCustomAttribute
SET	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser),
	ItemKey = ISNULL(@ItemKey, ItemKey),
	ItemValue = ISNULL(@ItemValue, ItemValue)
WHERE 	pkApplicationUserCustomAttribute = @pkApplicationUserCustomAttribute
