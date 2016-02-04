CREATE PROCEDURE [dbo].[uspDocumentDocTypeCacheRemove]
(
	@fkApplicationUser decimal(18,0) = NULL
)
AS

	IF (ISNULL(@fkApplicationUser,-1) = -1)
	BEGIN
		DELETE FROM DocumentDocTypeCache
	END
	ELSE
	BEGIN
		DELETE FROM DocumentDocTypeCache WHERE fkApplicationUser = @fkApplicationUser
	END