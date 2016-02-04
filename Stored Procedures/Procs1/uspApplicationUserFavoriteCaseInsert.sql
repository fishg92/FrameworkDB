
----------------------------------------------------------------------------
-- Insert a single record into ApplicationUserFavoriteCase
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspApplicationUserFavoriteCaseInsert]
(	  @fkApplicationUser decimal(18, 0) = NULL
	, @fkCPClientCase decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkApplicationUserFavoriteCase decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

if not exists(select 1 from ApplicationUserFavoriteCase where fkApplicationUser = @fkApplicationUser
				and fkCPClientCase = @fkCPClientCase)
Begin
	INSERT ApplicationUserFavoriteCase
	(	  fkApplicationUser
		, fkCPClientCase
	)
	VALUES 
	(	  @fkApplicationUser
		, @fkCPClientCase

	)

	SET @pkApplicationUserFavoriteCase = SCOPE_IDENTITY()
end
