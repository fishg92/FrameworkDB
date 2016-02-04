CREATE PROCEDURE [dbo].[uspDocumentDocTypeCacheAdd]
(
	  @fkApplicationUser decimal(18,0)
	, @SerializedDocTypes varbinary(max)
)
AS

	IF EXISTS (SELECT pkDocumentDocTypeCache FROM DocumentDocTypeCache WHERE fkApplicationUser = @fkApplicationUser)
	BEGIN
		UPDATE DocumentDocTypeCache 
		SET DocTypeList = @SerializedDocTypes 
		WHERE fkApplicationUser = @fkApplicationUser
	END
	ELSE
	BEGIN
		INSERT INTO DocumentDocTypeCache
		(
			  fkApplicationUser
			, DocTypeList
		) 
		VALUES
		(
			  @fkApplicationUser
			, @SerializedDocTypes
		)
	END