CREATE PROCEDURE [dbo].[uspFormAddForm]
(
	  @FriendlyName varchar(255)
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
	, @SingleUseDocTypeName varchar(255)
	, @DefaultFollowUpDays int = NULL
	, @CompressionWarning bit
	, @PrintRequired int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormName decimal(18, 0) output
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	INSERT INTO FormName
	(
		  FriendlyName
		, SystemName
		, NotToDMS
		, Renditions
		, [Status]
		, BarcodeDocType
		, BarcodeDocTypeName
		, FormDocType
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
	(
		  @FriendlyName
		, @SystemName
		, @NotToDMS
		, @Renditions
		, @Status
		, UPPER(@BarcodeDocType)
		, @BarcodeDocTypeName
		, UPPER(@FormDocType)
		, @BarcodeRequired
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