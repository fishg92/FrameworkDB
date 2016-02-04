CREATE PROC [dbo].[DocumentTypeDisplaySettingSelect]
AS

SELECT	DocumentTypeDisplaySetting.pkDocumentTypeDisplaySetting
		,DocumentTypeDisplaySetting.fkDocumentType
		,DocumentTypeDisplaySetting.NumberOfDisplayedDocs
		,DocumentTypeDisplaySetting.DateRangeDay
		,DocumentTypeDisplaySetting.DateRangeMonth
		,DocumentTypeDisplaySetting.DateRangeYear
		,fkDocumentOverlay = isnull(DocumentTypeDisplaySetting.fkDocumentOverlay,-1)
		,fkTaskType = isnull(DocumentTypeDisplaySetting.fkTaskType,1)
		,TaskTypeDescription = coalesce(refTaskType.Description,(select Description from refTaskType where pkrefTaskType = 1),'')
		,OverlayDescription = isnull(DocumentOverlay.Description,'')
		,SmartViewLimitDescription = '' --Filled in at service layer
		,DocumentTypeDescription = '' --Filled in at service layer
FROM	DocumentTypeDisplaySetting
left join refTaskType
	on DocumentTypeDisplaySetting.fkTaskType = refTaskType.pkrefTaskType
left join DocumentOverlay
	on DocumentTypeDisplaySetting.fkDocumentOverlay = DocumentOverlay.pkDocumentOverlay
	

