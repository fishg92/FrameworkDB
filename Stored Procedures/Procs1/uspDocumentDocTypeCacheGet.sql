CREATE PROCEDURE [dbo].[uspDocumentDocTypeCacheGet]
(
	  @fkApplicationUser decimal(18,0)
	, @SerializedDocTypes varbinary(max) = NULL OUTPUT
)
AS

	SELECT @SerializedDocTypes = DocTypeList 
	FROM DocumentDocTypeCache
	WHERE fkApplicationUser = @fkApplicationUser