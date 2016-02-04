
/*
exec [GetEventTypeDetail] 119
*/
CREATE proc [dbo].[GetEventTypeDetail]
	@fkEventType as decimal (18,0)
as

--EventTypes
SELECT
  pkEventType
, ET.Description as EventTypeDescription
, fkProgramType
, fkSmartView
, IncludeCaseworkerCases
, IncludeFavoriteCases
FROM EventType ET (nolock)
WHERE 	(pkEventType = @fkEventType)

--Audio
SELECT  
pkJoinEventTypeDocumentTypeAudio
,fkEventType
,fkDocumentType
FROM dbo.JoinEventTypeDocumentTypeAudio (nolock)
WHERE 	(fkEventType = @fkEventType)

--Capture
SELECT 
 pkJoinEventTypeDocumentTypeCapture
,fkEventType
,fkDocumentType
,SystemGeneratedCaption
FROM dbo.JoinEventTypeDocumentTypeCapture (nolock)
WHERE 	(fkEventType = @fkEventType)

--Forms
SELECT 
 pkJoinEventTypeFormName 
,fkEventType
,fkFormName
FROM dbo.JoinEventTypeFormName (nolock)
WHERE 	(fkEventType = @fkEventType)