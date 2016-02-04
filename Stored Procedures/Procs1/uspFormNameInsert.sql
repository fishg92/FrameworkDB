----------------------------------------------------------------------------
-- Insert a single record into FormName
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormNameInsert]
(	  @FriendlyName varchar(255)
	, @SystemName varchar(255)
	, @NotToDMS tinyint
	, @Renditions tinyint
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
	, @CompressionWarning bit
	, @PrintRequired int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkFormName decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormName
(	  FriendlyName
	, SystemName
	, NotToDMS
	, Renditions
	, [Status]
	, BarcodeDocType
	, BarcodeDocTypeName
	, FormDocType
	, HasBarcode
	, BarcodeRequired
	, RouteDocument
	, ForceSubmitOnFavorite
	, RequireClientSignature
	, SingleUseDocType
	, SingleUseDocTypeName
	, DefaultFollowUpDays
	, CompressionWarning
	, PrintRequired
)
VALUES 
(	  @FriendlyName
	, @SystemName
	, @NotToDMS
	, @Renditions
	, COALESCE(@Status, (0))
	, UPPER(@BarcodeDocType)
	, @BarcodeDocTypeName
	, UPPER(@FormDocType)
	, @HasBarcode
	, COALESCE(@BarcodeRequired, (0))
	, @RouteDocument
	, @ForceSubmitOnFavorite
	, @RequireClientSignature
	, UPPER(@SingleUseDocType)
	, @SingleUseDocTypeName
	, @DefaultFollowUpDays
	, @CompressionWarning
	, @PrintRequired
)

SET @pkFormName = SCOPE_IDENTITY()
