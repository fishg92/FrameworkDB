-- Stored Procedure

CREATE      Procedure [dbo].[uspFormEditForm]
(
	  @pkFormName decimal(10, 0)
	, @FriendlyName varchar(255)
	, @SystemName varchar(255)
	, @NotToDMS tinyint = 0
	, @Renditions tinyint = 0
	, @Status int = 0
	, @BarcodeDocType varchar(50) = ''
	, @BarcodeDocTypeName varchar(255) = ''
	, @FormDocType varchar(50) = ''
	, @BarcodeRequired int = 0
	, @RouteDocument smallint = 0
	, @ForceSubmitOnFavorite bit
	, @RequireClientSignature bit
	, @SingleUseDocType varchar(50) = ''
	, @SingleUseDocTypeName varchar(255) = ''
	, @DefaultFollowUpDays int = NULL
	, @CompressionWarning bit
	, @PrintRequired int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	UPDATE FormName 
	SET   FriendlyName = @FriendlyName
		, SystemName = @SystemName
		, NotToDMS = @NotToDMS
		, Renditions = @Renditions
		, [Status] = @Status
		, BarcodeDocType = UPPER(@BarcodeDocType)
		, BarcodeDocTypeName = @BarcodeDocTypeName
		, FormDocType = UPPER(@FormDocType)
		, BarcodeRequired = @BarcodeRequired
		, RouteDocument = @RouteDocument
		, ForceSubmitOnFavorite = @ForceSubmitOnFavorite
		, RequireClientSignature = @RequireClientSignature
		, SingleUseDocType = UPPER(@SingleUseDocType)
		, SingleUseDocTypeName = @SingleUseDocTypeName
		, DefaultFollowUpDays = @DefaultFollowUpDays
		, CompressionWarning = @CompressionWarning
		, PrintRequired = @PrintRequired
	WHERE pkFormName = @pkFormName
