
----------------------------------------------------------------------------
-- Select a single record from ProfileSetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspProfileSettingSelect]
(	@pkProfileSetting decimal(10, 0) = NULL,
	@Grouping varchar(200) = NULL,
	@ItemKey varchar(200) = NULL,
	@ItemValue varchar(max) = NULL,
	@AppID int = NULL,
	@fkProfile decimal(18, 0) = NULL
)
AS

SELECT	pkProfileSetting,
	Grouping,
	ItemKey,
	ItemValue,
	AppID,
	fkProfile
FROM	ProfileSetting
WHERE 	(@pkProfileSetting IS NULL OR pkProfileSetting = @pkProfileSetting)
 AND 	(@Grouping IS NULL OR Grouping LIKE @Grouping + '%')
 AND 	(@ItemKey IS NULL OR ItemKey LIKE @ItemKey + '%')
 AND 	(@ItemValue IS NULL OR ItemValue LIKE @ItemValue + '%')
 AND 	(@AppID IS NULL OR AppID = @AppID)
 AND 	(@fkProfile IS NULL OR fkProfile = @fkProfile)

