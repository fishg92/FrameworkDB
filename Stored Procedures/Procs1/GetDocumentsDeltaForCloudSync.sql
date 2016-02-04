

CREATE PROCEDURE [dbo].[GetDocumentsDeltaForCloudSync]
(
	@pkApplicationUser decimal,
	@pkConnectType decimal 
)

AS

DECLARE @Members table
(
	pkCPClient decimal,
	NorthwoodsNumber varchar(50),
	fkSmartView decimal
)

INSERT INTO @Members
SELECT DISTINCT cl.pkCPClient,
	            cl.NorthwoodsNumber,
				cs.fkSmartView
FROM (SELECT cc.pkCPClientCase,
			 et.fkSmartView
	  FROM JoinEventTypeConnectType jevtr 
	  INNER JOIN EventType et ON jevtr.fkEventType = et.pkEventType
	  INNER JOIN CPClientCase cc ON cc.fkCPRefClientCaseProgramType = et.fkProgramType and @pkApplicationUser = cc.fkApplicationUser
	  WHERE jevtr.fkConnectType = @pkConnectType AND et.IncludeCaseworkerCases = 1

	  UNION

	  SELECT cc.pkCPClientCase,
			 et.fkSmartView
	  FROM JoinEventTypeConnectType jevtr 
	  INNER JOIN EventType et ON jevtr.fkEventType = et.pkEventType
	  INNER JOIN CPClientCase cc ON cc.fkCPRefClientCaseProgramType = et.fkProgramType
	  
	  WHERE jevtr.fkConnectType = @pkConnectType 
	  AND (et.IncludeFavoriteCases = 1 
	  AND cc.pkCpClientCase in (SELECT fkCpClientCase 
							    FROM ApplicationUserFavoriteCase auf 
							    WHERE auf.fkApplicationUser = @pkApplicationUser))) cs
INNER JOIN CPJoinClientClientCase jcc ON jcc.fkCPClientCase = cs.pkCPClientCase
INNER JOIN CPClient cl ON cl.pkCPClient = jcc.fkCPClient

/* Related Members */

INSERT INTO @Members
SELECT cl.pkCPClient,
	   cl.NorthwoodsNumber,
	   m.fkSmartView
FROM (SELECT fkCPClientParent, fkCPClientChild
	  FROM CPJoinCPClientCPClientrefRelationship cjcr (NOLOCK)
	  INNER JOIN @Members pm ON pm.pkCPClient = cjcr.fkCPClientChild) cr
INNER JOIN CPClient cl ON cl.pkCPClient = cr.fkCPClientParent
INNER JOIN @Members m ON m.pkCPClient = cr.fkCPClientChild

UNION

SELECT cl.pkCPClient,
	   cl.NorthwoodsNumber,
	   m.fkSmartView
FROM (SELECT fkCPClientChild, fkCPClientParent
	  FROM CPJoinCPClientCPClientrefRelationship cjcr (NOLOCK)
	  INNER JOIN @Members pm ON pm.pkCPClient = cjcr.fkCPClientParent) cr
INNER JOIN CPClient cl ON cl.pkCPClient = cr.fkCPClientChild
INNER JOIN @Members m ON m.pkCPClient = cr.fkCPClientParent

DELETE FROM @Members 
WHERE pkCPClient in (SELECT pkCPClient 
					 FROM @Members 
					 GROUP BY pkCPClient
					 HAVING COUNT(*) > 1)
and fkSmartView = -1
					 
SELECT DISTINCT m.pkCPClient,
	            m.NorthwoodsNumber
FROM @Members m

SELECT DISTINCT pkCPClient,
	            fkSmartView
FROM @Members
WHERE fkSmartView <> -1

SELECT j.pkJoinSmartViewDocumentType,
	   j.NumberOfDisplayedDocs,
	   j.NumberOfDaysToDisplay,
	   j.IncludeInSmartView,
	   j.fkDocumentType,
	   j.fkSmartView,
	   j.NumberOfMonthsToDisplay,
	   j.NumberOfYearsToDisplay
FROM SmartView sv 
INNER JOIN JoinSmartViewDocumentType j on sv.pkSmartView = j.fkSmartView
WHERE sv.pkSmartView in (SELECT et.fkSmartView
						 FROM EventType et 
						 INNER JOIN JoinEventTypeConnectType jevtr ON jevtr.fkEventType = et.pkEventType
						 WHERE jevtr.fkConnectType = @pkConnectType)
AND j.IncludeInSmartView = 1
