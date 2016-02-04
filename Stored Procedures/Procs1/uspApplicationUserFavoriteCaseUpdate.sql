----------------------------------------------------------------------------
-- Update a single record in ApplicationUserFavoriteCase
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspApplicationUserFavoriteCaseUpdate]
(	  @pkApplicationUserFavoriteCase decimal(18, 0)
	, @fkApplicationUser decimal(18, 0) = NULL
	, @fkCPClientCase decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	ApplicationUserFavoriteCase
SET	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser),
	fkCPClientCase = ISNULL(@fkCPClientCase, fkCPClientCase)
WHERE 	pkApplicationUserFavoriteCase = @pkApplicationUserFavoriteCase
