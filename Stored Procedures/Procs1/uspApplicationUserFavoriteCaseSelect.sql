----------------------------------------------------------------------------
-- Select a single record from ApplicationUserFavoriteCase
----------------------------------------------------------------------------
CREATE PROC uspApplicationUserFavoriteCaseSelect
(	@pkApplicationUserFavoriteCase decimal(18, 0) = NULL,
	@fkApplicationUser decimal(18, 0) = NULL,
	@fkCPClientCase decimal(18, 0) = NULL
)
AS

SELECT	pkApplicationUserFavoriteCase,
	fkApplicationUser,
	fkCPClientCase
FROM	ApplicationUserFavoriteCase
WHERE 	(@pkApplicationUserFavoriteCase IS NULL OR pkApplicationUserFavoriteCase = @pkApplicationUserFavoriteCase)
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)
 AND 	(@fkCPClientCase IS NULL OR fkCPClientCase = @fkCPClientCase)

