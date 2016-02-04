
CREATE PROCEDURE [dbo].[GetCasesDeltaForCloudSync]
	@pkApplicationUser decimal,
	@pkConnectType decimal
AS
BEGIN

declare @Cases table
(
		pkCPClientCase decimal,
		fkApplicationUser decimal,
		LocalCaseNumber varchar (20),
		StateCaseNumber varchar (20),
		fkProgramType decimal,
		CreateDate datetime,
		FormallyKnownAs varchar (50)
)

DECLARE @CasesSyncItemType decimal(18,0) = 1;

insert into @Cases
SELECT cc.pkCPClientCase,
		cc.fkApplicationUser,
		cc.LocalCaseNumber,
		cc.StateCaseNumber,
		fkProgramType = cc.fkCPRefClientCaseProgramType,
		cc.CreateDate,
		FormallyKnownAs = ISNULL(ccs.FormallyKnownAs, '')
FROM JoinEventTypeConnectType jevtr 
INNER JOIN EventType et ON jevtr.fkEventType = et.pkEventType
INNER JOIN CPClientCase cc ON cc.fkCPRefClientCaseProgramType = et.fkProgramType and @pkApplicationUser = cc.fkApplicationUser
LEFT OUTER JOIN (SELECT * 
     FROM CompassCloudSyncItem c
     WHERE (c.SyncItemType = @CasesSyncItemType) AND c.fkApplicationUser = @pkApplicationUser) ccs ON ccs.fkSyncItem = cc.pkCPClientCase
WHERE jevtr.fkConnectType = @pkConnectType AND et.IncludeCaseworkerCases = 1

UNION

SELECT cc.pkCPClientCase,
		cc.fkApplicationUser,
		cc.LocalCaseNumber,
		cc.StateCaseNumber,
		fkProgramType = cc.fkCPRefClientCaseProgramType,
		cc.CreateDate,
		FormallyKnownAs = ISNULL(ccs.FormallyKnownAs, '')
FROM JoinEventTypeConnectType jevtr 
INNER JOIN EventType et ON jevtr.fkEventType = et.pkEventType
INNER JOIN CPClientCase cc ON cc.fkCPRefClientCaseProgramType = et.fkProgramType
LEFT OUTER JOIN (SELECT * 
        FROM CompassCloudSyncItem c
        WHERE (c.SyncItemType = 1) AND c.fkApplicationUser = @pkApplicationUser) ccs ON ccs.fkSyncItem = cc.pkCPClientCase
WHERE jevtr.fkConnectType = @pkConnectType 
AND (et.IncludeFavoriteCases = 1 AND cc.pkCpClientCase in (SELECT fkCpClientCase 
                 FROM ApplicationUserFavoriteCase auf 
                 WHERE auf.fkApplicationUser = @pkApplicationUser)) 

SELECT * from @Cases

SELECT ja.pkCPCaseActivity,
		ja.fkCPClientCase,
		ja.fkCPClient,	
		ja.CreateUser,
		ja.EffectiveCreateDate as CreateDate,
		ja.Description,
		FormerlyKnownAs = ISNULL(ccs.FormallyKnownAs, '')
FROM @Cases c
INNER JOIN CPCaseActivity ja ON ja.fkCPClientCase = c.pkCPClientCase
LEFT OUTER JOIN CompassCloudSyncItem ccs ON ja.pkCPCaseActivity = ccs.fkSyncItem AND ccs.SyncItemType = 7 AND ccs.fkApplicationUser = @pkApplicationUser

;WITH    q AS 
			(
			SELECT  MergedCase.*
			FROM    MergedCase
			Inner Join @Cases c on c.pkCPClientCase = MergedCase.fkCPMergeCase
			UNION ALL
			SELECT  m.*
			FROM    MergedCase m
			JOIN    q
			ON      m.fkCPMergeCase = q.fkCPClientCaseDuplicate
			)

	SELECT q.fkCPMergeCase as CaseId, q.fkCPClientCaseDuplicate as MergedFromId from q
	order by q.pkMergedCase desc

END