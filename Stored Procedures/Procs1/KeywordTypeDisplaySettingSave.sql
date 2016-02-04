
----------------------------------------------------------------------------
-- Insert a single record into KeywordTypeDisplaySetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[KeywordTypeDisplaySettingSave]
	  @fkKeywordType varchar(50)
	, @KeywordName varchar(50)
	, @DisplayInResultGrid bit = NULL
	, @Sequence int = NULL
	, @IsSearchable bit = NULL
	, @IncludeInExportManifest bit = null
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)  
    , @LUPMachine varchar(15)
    , @IsFreeform bit = NULL
    , @fkProfile decimal(18,0) = NULL
	, @IsRequiredByPilot bit 
	, @pkKeywordTypeDisplaySetting decimal(18, 0) = NULL OUTPUT 
	, @IsNotAutoIndexed bit = NULL
AS
/*
fkKeywordType should be unique by profile. Determine if a record already exists
for this fkKeywordType and profile and call the appropriate insert or update procedure
*/
set @pkKeywordTypeDisplaySetting = null

select	@pkKeywordTypeDisplaySetting = pkKeywordTypeDisplaySetting
from	dbo.KeywordTypeDisplaySetting
where	fkKeywordType = @fkKeywordType
		and fkProfile = @fkProfile


/* if this is a case of a keyword being added to the global profile, propagate it to 
 all of the existing profiles, defaulting all booleans to 0 per design meeting with JT,JN,AC,CH,GK,MH, and LT */
if @pkKeywordTypeDisplaySetting is null and @fkProfile = -1 BEGIN

		insert into KeywordTypeDisplaySetting
			(fkKeywordType
			,KeywordName
			,DisplayInResultGrid
			,Sequence
			,IsSearchable
			,IncludeInExportManifest
			,IsFreeform
			,fkProfile
			,IsRequiredByPilot
			,IsNotAutoIndexed)
		select
			@fkKeywordType
			,@KeywordName
			,0
			,0
			,0
			,0
			,0
			,a.fkProfile
			,0
			,0
		from
			( select distinct fkProfile 
				from KeywordTypeDisplaySetting  
				where fkProfile <>  -1 
					  and fkprofile Not In(select fkProfile
							     from  KeywordTypeDisplaySetting 
								 where fkKeywordType = @fkKeywordType )
								 ) a
END

if @pkKeywordTypeDisplaySetting is null
	begin
	
	exec dbo.uspKeywordTypeDisplaySettingInsert
		@fkKeywordType = @fkKeywordType
		, @KeywordName = @KeywordName
		, @DisplayInResultGrid = @DisplayInResultGrid
		, @Sequence = @Sequence
		, @IsSearchable = @IsSearchable
		, @IncludeInExportManifest = @IncludeInExportManifest
		, @LUPUser = @LUPUser
		, @LUPMac = @LUPMac
		, @LUPIP = @LUPIP
		, @LUPMachine = @LUPMachine
		, @IsFreeform = @IsFreeform
		, @fkProfile = @fkProfile
		, @IsRequiredByPilot = @IsRequiredByPilot
		, @IsNotAutoIndexed = @IsNotAutoIndexed
		, @pkKeywordTypeDisplaySetting = @pkKeywordTypeDisplaySetting output

	end
else
	begin	
	exec dbo.uspKeywordTypeDisplaySettingUpdate
		@pkKeywordTypeDisplaySetting = @pkKeywordTypeDisplaySetting
		, @fkKeywordType = @fkKeywordType
		, @KeywordName = @KeywordName
		, @DisplayInResultGrid = @DisplayInResultGrid
		, @Sequence = @Sequence
		, @IsSearchable = @IsSearchable
		, @IncludeInExportManifest = @IncludeInExportManifest
		, @LUPUser = @LUPUser
		, @LUPMac = @LUPMac
		, @LUPIP = @LUPIP
		, @LUPMachine = @LUPMachine
		, @IsFreeform = @IsFreeform
		, @fkProfile = @fkProfile
		, @IsNotAutoIndexed = @IsNotAutoIndexed
		, @IsRequiredByPilot = @IsRequiredByPilot
	end
