

CREATE proc [dbo].[uspDocumentsGetDocumentTypeDisplaySetting]
(		@fkDocumentType varchar(50) = Null
)
as

SELECT	pkDocumentTypeDisplaySetting,
		NumberOfDisplayedDocs, 
		DateRangeDay, 
		DateRangeMonth, 
		DateRangeYear 
FROM	DocumentTypeDisplaySetting 
WHERE	(@fkDocumentType is null or fkDocumentType = @fkDocumentType)



