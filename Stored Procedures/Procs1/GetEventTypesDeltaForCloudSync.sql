
CREATE PROCEDURE [dbo].[GetEventTypesDeltaForCloudSync]
(
	@pkApplicationUser decimal,
	@pkConnectType decimal 
)

AS

declare @EventTypes table
(
	pkEventType decimal,
	EventTypeDescription varchar(250),
	fkConnectType decimal,
	fkProgramType decimal, 
	fkSmartView decimal, 
	IncludeCaseworkerCases bit, 
	IncludeFavoriteCases bit,
	FormallyKnownAs varchar(50)
)

/* Event Type = 5 */

INSERT INTO @EventTypes
SELECT pkEventType, 
	   et.Description as EventTypeDescription, 
	   je.fkConnectType, 
	   fkProgramType, 
	   fkSmartView, 
	   IncludeCaseworkerCases, 
	   IncludeFavoriteCases,
	   FormallyKnownAs = ISNULL(ccs.FormallyKnownAs, '')
from EventType et 
INNER JOIN JoinEventTypeConnectType je on je.fkEventType = et.pkEventType
LEFT OUTER JOIN (SELECT * 
				 FROM CompassCloudSyncItem c
				 WHERE c.SyncItemType = 5 AND c.fkApplicationUser = @pkApplicationUser) ccs ON ccs.fkSyncItem = et.pkEventType
WHERE je.fkConnectType = @pkConnectType

/* Select the Event Types */
SELECT * FROM @EventTypes

/* Select the Audio Document Types */
SELECT fkEventType,
	   fkDocumentType
FROM JoinEventTypeDocumentTypeAudio da
INNER JOIN @EventTypes et ON da.fkEventType = et.pkEventType

/* Select the Capture Document Types */
SELECT fkEventType,
	   fkDocumentType,
	   SystemGeneratedCaption
FROM JoinEventTypeDocumentTypeCapture dc
INNER JOIN @EventTypes et ON dc.fkEventType = et.pkEventType

/* Select the Forms */
SELECT jfn.fkEventType,
       jfn.fkFormName,
	   fn.FormDocType
FROM JoinEventTypeFormName jfn
INNER JOIN @EventTypes et ON jfn.fkEventType = et.pkEventType
INNER JOIN FormName fn ON fn.pkFormName = jfn.fkFormName
WHERE fn.NotToDMS <> 1 AND fn.Status = 1

/* Select the Program Type names */
SELECT DISTINCT pkEventType,
	   ProgramTypeName = pt.ProgramType
FROM ProgramType pt
INNER JOIN @EventTypes et ON pt.pkProgramType = et.fkProgramType
