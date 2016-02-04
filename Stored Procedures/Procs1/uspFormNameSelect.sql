----------------------------------------------------------------------------
-- Select a single record from FormName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormNameSelect]
(	@pkFormName decimal(18, 0) = NULL,
	@FriendlyName varchar(255) = NULL,
	@SystemName varchar(255) = NULL,
	@NotToDMS tinyint = NULL,
	@Renditions tinyint = NULL,
	@Status tinyint = NULL,
	@BarcodeDocType varchar(50) = NULL,
	@BarcodeDocTypeName varchar(255) = NULL,
	@FormDocType varchar(50) = NULL,
	@HasBarcode bit = NULL,
	@BarcodeRequired int = NULL,
	@RouteDocument smallint = NULL,
	@ForceSubmitOnFavorite bit = NULL,
	@RequireClientSignature bit = NULL,
	@SingleUseDocType varchar(50) = NULL,
	@SingleUseDocTypeName varchar(255) = NULL,
	@DefaultFollowUpDays int = NULL,
	@CompressionWarning bit = NULL,
	@PrintRequired int = NULL
)
AS

SELECT	pkFormName,
	FriendlyName,
	SystemName,
	NotToDMS,
	Renditions,
	[Status],
	BarcodeDocType,
	BarcodeDocTypeName,
	FormDocType,
	HasBarcode,
	BarcodeRequired,
	RouteDocument,
	ForceSubmitOnFavorite,
	RequireClientSignature,
	SingleUseDocType,
	SingleUseDocTypeName,
	DefaultFollowUpDays,
	CompressionWarning,
	PrintRequired
FROM	FormName
WHERE 	(@pkFormName IS NULL OR pkFormName = @pkFormName)
 AND 	(@FriendlyName IS NULL OR FriendlyName LIKE @FriendlyName + '%')
 AND 	(@SystemName IS NULL OR SystemName LIKE @SystemName + '%')
 AND 	(@NotToDMS IS NULL OR NotToDMS = @NotToDMS)
 AND 	(@Renditions IS NULL OR Renditions = @Renditions)
 AND 	(@Status IS NULL OR Status = @Status)
 AND 	(@BarcodeDocType IS NULL OR BarcodeDocType LIKE @BarcodeDocType + '%')
 AND 	(@BarcodeDocTypeName IS NULL OR BarcodeDocTypeName LIKE @BarcodeDocTypeName + '%')
 AND 	(@FormDocType IS NULL OR FormDocType LIKE @FormDocType + '%')
 AND 	(@HasBarcode IS NULL OR HasBarcode = @HasBarcode)
 AND 	(@BarcodeRequired IS NULL OR BarcodeRequired = @BarcodeRequired)
 AND 	(@RouteDocument IS NULL OR RouteDocument = @RouteDocument)
 AND 	(@ForceSubmitOnFavorite IS NULL OR ForceSubmitOnFavorite = @ForceSubmitOnFavorite)
 AND 	(@RequireClientSignature IS NULL OR RequireClientSignature = @RequireClientSignature)
 AND 	(@SingleUseDocType IS NULL OR SingleUseDocType LIKE @SingleUseDocType + '%')
 AND 	(@SingleUseDocTypeName IS NULL OR SingleUseDocTypeName LIKE @SingleUseDocTypeName + '%')
 AND 	(@DefaultFollowUpDays IS NULL OR DefaultFollowUpDays = @DefaultFollowUpDays)
 AND	(@CompressionWarning IS NULL OR CompressionWarning = @CompressionWarning)
 AND	(@PrintRequired IS NULL OR PrintRequired = @PrintRequired)
