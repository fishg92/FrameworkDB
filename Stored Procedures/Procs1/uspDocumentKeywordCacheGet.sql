CREATE PROCEDURE [dbo].[uspDocumentKeywordCacheGet]
(
	  @fkApplicationUser decimal(18,0)
	, @SerializedKeywords varbinary(max) = NULL OUTPUT
)
AS

	SELECT @SerializedKeywords = KeywordList 
	FROM DocumentKeywordCache
	WHERE fkApplicationUser = @fkApplicationUser