----------------------------------------------------------------------------
-- Insert a single record into FormUserSetting
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormUserSettingInsert]
(	  @fkFrameworkUserID decimal(18, 0)
	, @ReturnAddress varchar(1000) = NULL
	, @DateFormatMask varchar(50) = NULL
	, @Signature image = NULL
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
	, @pkFormUserSetting decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormUserSetting
(	  fkFrameworkUserID
	, ReturnAddress
	, DateFormatMask
	, Signature
	, SignatureString
	, SignatureHeight
	, SignatureWidth
	, SignatureDPIX
	, SignatureDPIY
	, fkActiveAutofill
	, SignatureDensity
	, FilterSearchString
	, FilterSearchAllFolders
	, FilterShowForms
	, FilterShowGroups
	, OpenInDesignMode
	, PrintJobSortOrder
	, PrintJobSortColumn
	, ClickReOrderDialogHeight
	, ClickReOrderDialogWidth
)
VALUES 
(	  @fkFrameworkUserID
	, @ReturnAddress
	, @DateFormatMask
	, @Signature
	, @SignatureString
	, @SignatureHeight
	, @SignatureWidth
	, @SignatureDPIX
	, @SignatureDPIY
	, @fkActiveAutofill
	, @SignatureDensity
	, COALESCE(@FilterSearchString, '')
	, COALESCE(@FilterSearchAllFolders, (0))
	, COALESCE(@FilterShowForms, (1))
	, COALESCE(@FilterShowGroups, (1))
	, COALESCE(@OpenInDesignMode, (0))
	, COALESCE(@PrintJobSortOrder, 'None')
	, COALESCE(@PrintJobSortColumn, (0))
	, COALESCE(@ClickReOrderDialogHeight, (523))
	, COALESCE(@ClickReOrderDialogWidth, (451))

)

SET @pkFormUserSetting = SCOPE_IDENTITY()
