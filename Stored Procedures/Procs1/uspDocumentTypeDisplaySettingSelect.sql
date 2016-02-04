----------------------------------------------------------------------------
-- Select a single record from DocumentTypeDisplaySetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspDocumentTypeDisplaySettingSelect]
(	@pkDocumentTypeDisplaySetting decimal(18, 0) = NULL,
	@fkDocumentType varchar(50) = NULL,
	@fkDocumentOverlay decimal(18, 0) = NULL,
	@fkTaskType decimal(18, 0) = NULL,
	@DocTypeDescription_SupportUseOnly varchar(500) = NULL
)
AS

SELECT	pkDocumentTypeDisplaySetting,
	fkDocumentType,
	NumberOfDisplayedDocs,
	DateRangeDay,
	DateRangeMonth,
	DateRangeYear,
	fkDocumentOverlay,
	fkTaskType,
	DocTypeDescription_SupportUseOnly
FROM	DocumentTypeDisplaySetting
WHERE 	(@pkDocumentTypeDisplaySetting IS NULL OR pkDocumentTypeDisplaySetting = @pkDocumentTypeDisplaySetting)
 AND 	(@fkDocumentType IS NULL OR fkDocumentType LIKE @fkDocumentType + '%')
 AND 	(@fkDocumentOverlay IS NULL OR fkDocumentOverlay = @fkDocumentOverlay)
 AND 	(@fkTaskType IS NULL OR fkTaskType = @fkTaskType)
 AND 	(@DocTypeDescription_SupportUseOnly IS NULL OR DocTypeDescription_SupportUseOnly LIKE @DocTypeDescription_SupportUseOnly + '%')

