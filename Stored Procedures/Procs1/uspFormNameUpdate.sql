----------------------------------------------------------------------------
-- Update a single record in FormName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormNameUpdate]
(	  @pkFormName decimal(18, 0)
	, @FriendlyName varchar(255) = NULL
	, @SystemName varchar(255) = NULL
	, @NotToDMS tinyint = NULL
	, @Renditions tinyint = NULL
	, @Status tinyint = NULL
	, @BarcodeDocType varchar(50) = NULL
	, @BarcodeDocTypeName varchar(255) = NULL
	, @FormDocType varchar(50) = NULL
	, @HasBarcode bit = NULL
	, @BarcodeRequired int = NULL
	, @RouteDocument smallint = NULL
	, @ForceSubmitOnFavorite bit = NULL
	, @RequireClientSignature bit = NULL
	, @SingleUseDocType varchar(50) = NULL
	, @SingleUseDocTypeName varchar(255) = NULL
	, @DefaultFollowUpDays int = NULL
	, @CompressionWarning bit = NULL
	, @PrintRequired int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormName
SET	FriendlyName = ISNULL(@FriendlyName, FriendlyName),
	SystemName = ISNULL(@SystemName, SystemName),
	NotToDMS = ISNULL(@NotToDMS, NotToDMS),
	Renditions = ISNULL(@Renditions, Renditions),
	[Status] = ISNULL(COALESCE(@Status, (0)), [Status]),
	BarcodeDocType = UPPER(ISNULL(@BarcodeDocType, BarcodeDocType)),
	BarcodeDocTypeName = ISNULL(@BarcodeDocTypeName, BarcodeDocTypeName),
	FormDocType = UPPER(ISNULL(@FormDocType, FormDocType)),
	HasBarcode = ISNULL(@HasBarcode, HasBarcode),
	BarcodeRequired = ISNULL(COALESCE(@BarcodeRequired, (0)), BarcodeRequired),
	RouteDocument = ISNULL(@RouteDocument, RouteDocument),
	ForceSubmitOnFavorite = ISNULL(@ForceSubmitOnFavorite, ForceSubmitOnFavorite),
	RequireClientSignature = ISNULL(@RequireClientSignature, RequireClientSignature),
	SingleUseDocType = UPPER(ISNULL(@SingleUseDocType, SingleUseDocType)),
	SingleUseDocTypeName = ISNULL(@SingleUseDocTypeName, SingleUseDocTypeName),
	DefaultFollowUpDays = ISNULL(@DefaultFollowUpDays, DefaultFollowUpDays),
	CompressionWarning = ISNULL(@CompressionWarning, CompressionWarning),
	PrintRequired = ISNULL(@PrintRequired, PrintRequired)
WHERE 	pkFormName = @pkFormName
