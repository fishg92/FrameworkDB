----------------------------------------------------------------------------
-- Select a single record from KeywordTypeDisplaySetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspKeywordTypeDisplaySettingSelect]
(	@pkKeywordTypeDisplaySetting decimal(18, 0) = NULL,
	@fkKeywordType varchar(50) = NULL,
	@KeywordName varchar(50) = NULL,
	@DisplayInResultGrid bit = NULL,
	@Sequence int = NULL,
	@IsSearchable bit = NULL,
	@IncludeInExportManifest bit = NULL,
	@IsFreeform bit = NULL,
	@fkProfile decimal(18, 0) = NULL,
	@IsRequiredByPilot bit = NULL,
	@IsNotAutoIndexed bit = Null
)
AS

SELECT	pkKeywordTypeDisplaySetting,
	fkKeywordType,
	KeywordName,
	DisplayInResultGrid,
	Sequence,
	IsSearchable,
	IncludeInExportManifest,
	IsFreeform,
	fkProfile,
	IsRequiredByPilot,
	IsNotAutoIndexed
FROM	KeywordTypeDisplaySetting
WHERE 	(@pkKeywordTypeDisplaySetting IS NULL OR pkKeywordTypeDisplaySetting = @pkKeywordTypeDisplaySetting)
 AND 	(@fkKeywordType IS NULL OR fkKeywordType LIKE @fkKeywordType + '%')
 AND 	(@KeywordName IS NULL OR KeywordName LIKE @KeywordName + '%')
 AND 	(@DisplayInResultGrid IS NULL OR DisplayInResultGrid = @DisplayInResultGrid)
 AND 	(@Sequence IS NULL OR Sequence = @Sequence)
 AND 	(@IsSearchable IS NULL OR IsSearchable = @IsSearchable)
 AND 	(@IncludeInExportManifest IS NULL OR IncludeInExportManifest = @IncludeInExportManifest)
 AND 	(@IsFreeform IS NULL OR IsFreeform = @IsFreeform)
 AND 	(@fkProfile IS NULL OR fkProfile = @fkProfile)
 AND 	(@IsRequiredByPilot IS NULL OR IsRequiredByPilot = @IsRequiredByPilot)
 AND	(@IsNotAutoIndexed IS NULL or IsNotAutoIndexed = @IsNotAutoIndexed)

