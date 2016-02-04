----------------------------------------------------------------------------
-- Insert a single record into KeywordTypeDisplaySetting
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspKeywordTypeDisplaySettingInsert]
(	  @fkKeywordType varchar(50)
	, @KeywordName varchar(50)
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
	, @pkKeywordTypeDisplaySetting decimal(18, 0) = NULL OUTPUT 
	, @IsNotAutoIndexed bit = 0
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT KeywordTypeDisplaySetting
(	  fkKeywordType
	, KeywordName
	, DisplayInResultGrid
	, Sequence
	, IsSearchable
	, IncludeInExportManifest
	, IsFreeform
	, fkProfile
	, IsRequiredByPilot
	, IsNotAutoIndexed
)
VALUES 
(	  @fkKeywordType
	, @KeywordName
	, COALESCE(@DisplayInResultGrid, (0))
	, COALESCE(@Sequence, (0))
	, COALESCE(@IsSearchable, (1))
	, COALESCE(@IncludeInExportManifest, (0))
	, COALESCE(@IsFreeform, (0))
	, COALESCE(@fkProfile, (-1))
	, COALESCE(@IsRequiredByPilot, (0))
	, @IsNotAutoIndexed

)

SET @pkKeywordTypeDisplaySetting = SCOPE_IDENTITY()
