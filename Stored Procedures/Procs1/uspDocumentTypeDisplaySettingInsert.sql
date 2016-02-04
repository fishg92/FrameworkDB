----------------------------------------------------------------------------
-- Insert a single record into DocumentTypeDisplaySetting
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspDocumentTypeDisplaySettingInsert]
(	  @fkDocumentType varchar(50)
	, @fkDocumentOverlay decimal(18, 0) = NULL
	, @fkTaskType decimal(18, 0) = NULL
	, @DocTypeDescription_SupportUseOnly varchar(500) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkDocumentTypeDisplaySetting decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT DocumentTypeDisplaySetting
(	  fkDocumentType
	, NumberOfDisplayedDocs
	, DateRangeDay
	, DateRangeMonth
	, DateRangeYear
	, fkDocumentOverlay
	, fkTaskType
	, DocTypeDescription_SupportUseOnly
)
VALUES 
(	  @fkDocumentType
	,0
	, 0
	, 0
	, 0
	, @fkDocumentOverlay
	, @fkTaskType
	, COALESCE(@DocTypeDescription_SupportUseOnly, '')

)

SET @pkDocumentTypeDisplaySetting = SCOPE_IDENTITY()
