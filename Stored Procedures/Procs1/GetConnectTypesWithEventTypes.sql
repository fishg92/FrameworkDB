
--exec [GetConnectTypesWithEventTypes] 1
CREATE PROC [dbo].[GetConnectTypesWithEventTypes]
(	@pkConnectType decimal(18, 0) = NULL
)
AS

SELECT
  pkConnectType
, Description as ConnectTypeDescription
, EnableCloudSync
, SyncInterval
, SyncProviderType
FROM	ConnectType
WHERE 	(@pkConnectType IS NULL OR pkConnectType = @pkConnectType)

SELECT
  pkEventType
, ET.Description as EventTypeDescription
, JETTT.fkConnectType
, fkProgramType
, fkSmartView
, IncludeCaseworkerCases
, IncludeFavoriteCases
from EventType ET (nolock)
inner join JoinEventTypeConnectType JETTT (nolock) on JETTT.fkEventType = ET.pkEventType
WHERE 	(@pkConnectType IS NULL OR JETTT.fkConnectType = @pkConnectType)
