----------------------------------------------------------------------------
-- Delete a single record from ApplicationUserFavoriteCase
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspApplicationUserFavoriteCaseDeleteByCaseAndUser]
(	  @fkApplicationUser decimal(18, 0)
	, @fkCPClientCase decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine


DELETE	ApplicationUserFavoriteCase
WHERE 	fkApplicationUser = @fkApplicationUser
AND		fkCPClientCase = @fkCPClientCase
