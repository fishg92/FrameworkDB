
CREATE PROCEDURE [dbo].[uspFormAddUpgradeForm]
(
	  @FriendlyName varchar(255)
	, @SystemName varchar(255)
	, @NotToDMS tinyint = 0
	, @Renditions tinyint = 0
	, @Status int = 0
	, @FileExtension varchar(10)
	, @BarcodeDocType int = 0
	, @BarcodeDocTypeName varchar(255) = ''
	, @FormDocType int = 0
	, @BarcodeRequired int = 0
	, @RouteDocument smallint = 0
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormPath decimal(18, 0) output
	, @FormPath varchar(500) output
	, @pkFormName decimal(18, 0) output
)
AS

	DECLARE @FormRelativePath varchar(255)

	SET @FormRelativePath = (SELECT AttributeValue FROM NCPSystem WHERE Attribute = 'FormWorkingDirectory')

	IF ISNULL(@FormRelativePath,'') <> ''
	BEGIN

		INSERT INTO FormName
		(
			  FriendlyName
			, SystemName
			, NotToDMS
			, Renditions
			, Status
			, BarcodeDocType
			, BarcodeDocTypeName
			, FormDocType
			, BarcodeRequired
			, RouteDocument
		)
		VALUES
		(
			  @FriendlyName
			, @SystemName
			, @NotToDMS
			, @Renditions
			, @Status
			, @BarcodeDocType
			, @BarcodeDocTypeName
			, @FormDocType
			, @BarcodeRequired
			, @RouteDocument
		)
		
		SET @pkFormName = SCOPE_IDENTITY()
	
		/* Use our form name key to assign the file a path */
		
		INSERT INTO FormPath
		(	fkFormName)
		VALUES
		(	@pkFormName)

		SET @pkFormPath = SCOPE_IDENTITY()

		/* Use the pkFormPath to name our file in the system specified forms store */
		
		SET @FormPath = @FormRelativePath + RTRIM(CONVERT(varchar(50), @pkFormPath)) + 'Upgrade' + @FileExtension

		UPDATE FormPath 
		SET [Path] = @FormPath 
		WHERE pkFormPath = @pkFormPath

	END
