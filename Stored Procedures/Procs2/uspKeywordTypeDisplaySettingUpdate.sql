----------------------------------------------------------------------------
-- Update a single record in KeywordTypeDisplaySetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspKeywordTypeDisplaySettingUpdate]
(	  @pkKeywordTypeDisplaySetting decimal(18, 0)
	, @fkKeywordType varchar(50) = NULL
	, @KeywordName varchar(50) = NULL
	, @DisplayInResultGrid bit = NULL
	, @Sequence int = NULL
	, @IsSearchable bit = NULL
	, @IncludeInExportManifest bit = NULL
	, @IsFreeform bit = NULL
	, @fkProfile decimal(18, 0) = NULL
	, @IsRequiredByPilot bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @IsNotAutoIndexed bit = 0
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	KeywordTypeDisplaySetting
SET	fkKeywordType = ISNULL(@fkKeywordType, fkKeywordType),
	KeywordName = ISNULL(@KeywordName, KeywordName),
	DisplayInResultGrid = ISNULL(@DisplayInResultGrid, DisplayInResultGrid),
	Sequence = ISNULL(@Sequence, Sequence),
	IsSearchable = ISNULL(@IsSearchable, IsSearchable),
	IncludeInExportManifest = ISNULL(@IncludeInExportManifest, IncludeInExportManifest),
	IsFreeform = ISNULL(@IsFreeform, IsFreeform),
	fkProfile = ISNULL(@fkProfile, fkProfile),
	IsRequiredByPilot = ISNULL(@IsRequiredByPilot, IsRequiredByPilot),
	IsNotAutoIndexed = @IsNotAutoIndexed
WHERE 	pkKeywordTypeDisplaySetting = @pkKeywordTypeDisplaySetting
