CREATE PROCEDURE [dbo].[uspDocumentKeywordCacheAdd]
(
	  @fkApplicationUser decimal(18,0)
	, @SerializedKeywords varbinary(max)
)
AS

	IF EXISTS (SELECT pkDocumentKeywordCache FROM DocumentKeywordCache WHERE fkApplicationUser = @fkApplicationUser)
	BEGIN
		UPDATE DocumentKeywordCache 
		SET KeywordList = @SerializedKeywords 
		WHERE fkApplicationUser = @fkApplicationUser
	END
	ELSE
	BEGIN
		INSERT INTO DocumentKeywordCache
		(
			  fkApplicationUser
			, KeywordList
		) 
		VALUES
		(
			  @fkApplicationUser
			, @SerializedKeywords
		)
	END