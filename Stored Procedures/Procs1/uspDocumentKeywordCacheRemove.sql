CREATE PROCEDURE [dbo].[uspDocumentKeywordCacheRemove]
(
	@fkApplicationUser decimal(18,0) = NULL
)
AS

	IF (ISNULL(@fkApplicationUser,-1) = -1)
	BEGIN
		DELETE FROM DocumentKeywordCache
	END
	ELSE
	BEGIN
		DELETE FROM DocumentKeywordCache WHERE fkApplicationUser = @fkApplicationUser
	END