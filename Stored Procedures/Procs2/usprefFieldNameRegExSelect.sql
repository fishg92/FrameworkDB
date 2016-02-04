----------------------------------------------------------------------------
-- Select a single record from refFieldNameRegEx
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefFieldNameRegExSelect]
(	@pkrefFieldNameRegEx decimal(18, 0) = NULL,
	@regExValues varchar(150) = NULL,
	@regFieldName varchar(250) = NULL,
	@FriendlyName varchar(250) = NULL
)
AS

SELECT	pkrefFieldNameRegEx,
	regExValues,
	regFieldName,
	FriendlyName
FROM	refFieldNameRegEx
WHERE 	(@pkrefFieldNameRegEx IS NULL OR pkrefFieldNameRegEx = @pkrefFieldNameRegEx)
 AND 	(@regExValues IS NULL OR regExValues LIKE @regExValues + '%')
 AND 	(@regFieldName IS NULL OR regFieldName LIKE @regFieldName + '%')
 AND 	(@FriendlyName IS NULL OR FriendlyName LIKE @FriendlyName + '%')
