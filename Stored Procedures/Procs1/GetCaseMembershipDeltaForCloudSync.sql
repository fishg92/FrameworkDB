
CREATE PROCEDURE [dbo].[GetCaseMembershipDeltaForCloudSync]
(
	@pkApplicationUser decimal,
	@pkConnectType decimal
)

AS

SELECT DISTINCT jcc.pkCPJoinClientClientCase,
	   jcc.fkCPClient,
	   jcc.fkCPClientCase,
	   jcc.PrimaryParticipantOnCase,
	   FormallyKnownAs = ISNULL(ccs.FormallyKnownAs, '')
FROM JoinEventTypeConnectType jevtr 
INNER JOIN EventType et ON jevtr.fkEventType = et.pkEventType
INNER JOIN CPClientCase cc ON cc.fkCPRefClientCaseProgramType = et.fkProgramType and @pkApplicationUser = cc.fkApplicationUser
INNER JOIN CPJoinClientClientCase jcc ON jcc.fkCPClientCase = cc.pkCPClientCase
LEFT OUTER JOIN CompassCloudSyncItem ccs ON jcc.pkCPJoinClientClientCase = ccs.fkSyncItem AND ccs.SyncItemType = 18 AND ccs.fkApplicationUser = @pkApplicationUser
WHERE jevtr.fkConnectType = @pkConnectType AND et.IncludeCaseworkerCases = 1

UNION

SELECT DISTINCT jcc.pkCPJoinClientClientCase,
	   jcc.fkCPClient,
	   jcc.fkCPClientCase,
	   jcc.PrimaryParticipantOnCase,
	   FormallyKnownAs = ISNULL(ccs.FormallyKnownAs, '')
FROM JoinEventTypeConnectType jevtr 
INNER JOIN EventType et ON jevtr.fkEventType = et.pkEventType
INNER JOIN CPClientCase cc ON cc.fkCPRefClientCaseProgramType = et.fkProgramType
INNER JOIN CPJoinClientClientCase jcc ON jcc.fkCPClientCase = cc.pkCPClientCase
LEFT OUTER JOIN CompassCloudSyncItem ccs ON jcc.pkCPJoinClientClientCase = ccs.fkSyncItem AND ccs.SyncItemType = 18 AND ccs.fkApplicationUser = @pkApplicationUser
WHERE jevtr.fkConnectType = @pkConnectType 
AND (et.IncludeFavoriteCases = 1 
AND cc.pkCpClientCase in (SELECT fkCpClientCase 
						FROM ApplicationUserFavoriteCase auf 
						WHERE auf.fkApplicationUser = @pkApplicationUser))