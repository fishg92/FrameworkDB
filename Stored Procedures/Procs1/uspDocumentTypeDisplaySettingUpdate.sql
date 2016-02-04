----------------------------------------------------------------------------
-- Update a single record in DocumentTypeDisplaySetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspDocumentTypeDisplaySettingUpdate]
(	  @pkDocumentTypeDisplaySetting decimal(18, 0)
	, @fkDocumentType varchar(50) = NULL
	, @fkDocumentOverlay decimal(18, 0) = NULL
	, @fkTaskType decimal(18, 0) = NULL
	, @DocTypeDescription_SupportUseOnly varchar(500) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	DocumentTypeDisplaySetting
SET	fkDocumentType = ISNULL(@fkDocumentType, fkDocumentType),
	fkDocumentOverlay = ISNULL(@fkDocumentOverlay, fkDocumentOverlay),
	fkTaskType = ISNULL(@fkTaskType, fkTaskType),
	DocTypeDescription_SupportUseOnly = ISNULL(@DocTypeDescription_SupportUseOnly, DocTypeDescription_SupportUseOnly)
WHERE 	pkDocumentTypeDisplaySetting = @pkDocumentTypeDisplaySetting
