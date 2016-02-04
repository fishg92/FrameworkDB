----------------------------------------------------------------------------
-- Select a single record from FormUserSetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormUserSettingSelect]
(	@pkFormUserSetting decimal(18, 0) = NULL,
	@fkFrameworkUserID decimal(18, 0) = NULL,
	@ReturnAddress varchar(1000) = NULL,
	@DateFormatMask varchar(50) = NULL,
	@Signature image = NULL,
	@SignatureString text = NULL,
	@SignatureHeight int = NULL,
	@SignatureWidth int = NULL,
	@SignatureDPIX int = NULL,
	@SignatureDPIY int = NULL,
	@fkActiveAutofill decimal(18, 0) = NULL,
	@SignatureDensity int = NULL,
	@FilterSearchString varchar(30) = NULL,
	@FilterSearchAllFolders bit = NULL,
	@FilterShowForms bit = NULL,
	@FilterShowGroups bit = NULL,
	@OpenInDesignMode bit = NULL,
	@PrintJobSortOrder varchar(10) = NULL,
	@PrintJobSortColumn tinyint = NULL,
	@LUPUser varchar(50) = NULL,
	@LUPDate datetime = NULL,
	@CreateUser varchar(50) = NULL,
	@CreateDate datetime = NULL,
	@ClickReOrderDialogHeight int = NULL,
	@ClickReOrderDialogWidth int = NULL
)
AS

SELECT	pkFormUserSetting,
	fkFrameworkUserID,
	ReturnAddress,
	DateFormatMask,
	Signature,
	SignatureString,
	SignatureHeight,
	SignatureWidth,
	SignatureDPIX,
	SignatureDPIY,
	fkActiveAutofill,
	SignatureDensity,
	FilterSearchString,
	FilterSearchAllFolders,
	FilterShowForms,
	FilterShowGroups,
	OpenInDesignMode,
	PrintJobSortOrder,
	PrintJobSortColumn,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate,
	ClickReOrderDialogHeight,
	ClickReOrderDialogWidth
FROM	FormUserSetting
WHERE 	(@pkFormUserSetting IS NULL OR pkFormUserSetting = @pkFormUserSetting)
 AND 	(@fkFrameworkUserID IS NULL OR fkFrameworkUserID = @fkFrameworkUserID)
 AND 	(@ReturnAddress IS NULL OR ReturnAddress LIKE @ReturnAddress + '%')
 AND 	(@DateFormatMask IS NULL OR DateFormatMask LIKE @DateFormatMask + '%')
 AND 	(@SignatureHeight IS NULL OR SignatureHeight = @SignatureHeight)
 AND 	(@SignatureWidth IS NULL OR SignatureWidth = @SignatureWidth)
 AND 	(@SignatureDPIX IS NULL OR SignatureDPIX = @SignatureDPIX)
 AND 	(@SignatureDPIY IS NULL OR SignatureDPIY = @SignatureDPIY)
 AND 	(@fkActiveAutofill IS NULL OR fkActiveAutofill = @fkActiveAutofill)
 AND 	(@SignatureDensity IS NULL OR SignatureDensity = @SignatureDensity)
 AND 	(@FilterSearchString IS NULL OR FilterSearchString LIKE @FilterSearchString + '%')
 AND 	(@FilterSearchAllFolders IS NULL OR FilterSearchAllFolders = @FilterSearchAllFolders)
 AND 	(@FilterShowForms IS NULL OR FilterShowForms = @FilterShowForms)
 AND 	(@FilterShowGroups IS NULL OR FilterShowGroups = @FilterShowGroups)
 AND 	(@OpenInDesignMode IS NULL OR OpenInDesignMode = @OpenInDesignMode)
 AND 	(@PrintJobSortOrder IS NULL OR PrintJobSortOrder LIKE @PrintJobSortOrder + '%')
 AND 	(@PrintJobSortColumn IS NULL OR PrintJobSortColumn = @PrintJobSortColumn)
 AND 	(@LUPUser IS NULL OR LUPUser LIKE @LUPUser + '%')
 AND 	(@LUPDate IS NULL OR LUPDate = @LUPDate)
 AND 	(@CreateUser IS NULL OR CreateUser LIKE @CreateUser + '%')
 AND 	(@CreateDate IS NULL OR CreateDate = @CreateDate)
 AND 	(@ClickReOrderDialogHeight IS NULL OR ClickReOrderDialogHeight = @ClickReOrderDialogHeight)
 AND 	(@ClickReOrderDialogWidth IS NULL OR ClickReOrderDialogWidth = @ClickReOrderDialogWidth)

