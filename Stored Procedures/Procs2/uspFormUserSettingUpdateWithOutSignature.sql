-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormUserSetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormUserSettingUpdateWithOutSignature]
(	  @pkFormUserSetting decimal(18, 0)
	, @fkFrameworkUserID decimal(18, 0) = NULL
	, @ReturnAddress varchar(1000) = NULL
	, @DateFormatMask varchar(50) = NULL
	, @SignatureString text = NULL
	, @SignatureHeight int = NULL
	, @SignatureWidth int = NULL
	, @SignatureDPIX int = NULL
	, @SignatureDPIY int = NULL
	, @fkActiveAutofill decimal(18, 0) = NULL
	, @SignatureDensity int = NULL
	, @FilterSearchString varchar(30) = NULL
	, @FilterSearchAllFolders bit = NULL
	, @FilterShowForms bit = NULL
	, @FilterShowGroups bit = NULL
	, @OpenInDesignMode bit = NULL
	, @PrintJobSortOrder varchar(10) = NULL
	, @PrintJobSortColumn tinyint = NULL
	, @ClickReOrderDialogHeight int = NULL
	, @ClickReOrderDialogWidth int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormUserSetting
SET	fkFrameworkUserID = ISNULL(@fkFrameworkUserID, fkFrameworkUserID),
	ReturnAddress = ISNULL(@ReturnAddress, ReturnAddress),
	DateFormatMask = ISNULL(@DateFormatMask, DateFormatMask),
	SignatureString = ISNULL(@SignatureString, SignatureString),
	SignatureHeight = ISNULL(@SignatureHeight, SignatureHeight),
	SignatureWidth = ISNULL(@SignatureWidth, SignatureWidth),
	SignatureDPIX = ISNULL(@SignatureDPIX, SignatureDPIX),
	SignatureDPIY = ISNULL(@SignatureDPIY, SignatureDPIY),
	fkActiveAutofill = ISNULL(@fkActiveAutofill, fkActiveAutofill),
	SignatureDensity = ISNULL(@SignatureDensity, SignatureDensity),
	FilterSearchString = ISNULL(@FilterSearchString, FilterSearchString),
	FilterSearchAllFolders = ISNULL(@FilterSearchAllFolders, FilterSearchAllFolders),
	FilterShowForms = ISNULL(@FilterShowForms, FilterShowForms),
	FilterShowGroups = ISNULL(@FilterShowGroups, FilterShowGroups),
	OpenInDesignMode = ISNULL(@OpenInDesignMode, OpenInDesignMode),
	PrintJobSortOrder = ISNULL(@PrintJobSortOrder, PrintJobSortOrder),
	PrintJobSortColumn = ISNULL(@PrintJobSortColumn, PrintJobSortColumn),
	ClickReOrderDialogHeight = ISNULL(@ClickReOrderDialogHeight, ClickReOrderDialogHeight),
	ClickReOrderDialogWidth = ISNULL(@ClickReOrderDialogWidth, ClickReOrderDialogWidth)
WHERE 	pkFormUserSetting = @pkFormUserSetting
