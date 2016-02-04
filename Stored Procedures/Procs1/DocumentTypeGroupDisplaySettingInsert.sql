


----------------------------------------------------------------------------
-- Insert a single record into DocumentTypeGroupDisplaySetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[DocumentTypeGroupDisplaySettingInsert]
(	  @fkDocumentTypeGroup varchar(50)
	, @DisplayColor int
	, @Sequence int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkDocumentTypeGroupDisplaySetting decimal(18, 0) = NULL OUTPUT 
)
AS

declare @pkCurrent decimal

select	@pkCurrent = pkDocumentTypeGroupDisplaySetting
from	dbo.DocumentTypeGroupDisplaySetting
where	fkDocumentTypeGroup = @fkDocumentTypeGroup

if @pkCurrent is null
	begin
	exec dbo.uspDocumentTypeGroupDisplaySettingInsert
		@fkDocumentTypeGroup = @fkDocumentTypeGroup
		, @DisplayColor = @DisplayColor
		, @Sequence = @Sequence
		, @LUPUser = @LUPUser
		, @LUPMac = @LUPMac
		, @LUPIP = @LUPIP
		, @LUPMachine = @LUPMachine
		, @pkDocumentTypeGroupDisplaySetting = @pkDocumentTypeGroupDisplaySetting output
	end
else
	begin
	exec dbo.uspDocumentTypeGroupDisplaySettingUpdate
		@pkDocumentTypeGroupDisplaySetting = @pkCurrent
		, @fkDocumentTypeGroup = @fkDocumentTypeGroup
		, @DisplayColor = @DisplayColor
		, @Sequence = @Sequence
		, @LUPUser = @LUPUser
		, @LUPMac = @LUPMac
		, @LUPIP = @LUPIP
		, @LUPMachine = @LUPMachine
	
	set @pkDocumentTypeGroupDisplaySetting = @pkCurrent
	end

