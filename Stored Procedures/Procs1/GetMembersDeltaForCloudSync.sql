
CREATE PROCEDURE [dbo].[GetMembersDeltaForCloudSync]
(
	@pkApplicationUser decimal,
	@pkConnectType decimal
)

AS

DECLARE @PrimaryMembers table
(
	pkCPClient decimal,
	LastName varchar(100),
	FirstName varchar(100),
	MiddleName varchar(100),
	SSN char(10),
	StateIssuedNumber varchar(50),
	NorthwoodsNumber varchar(50),
	MaidenName varchar(100),
	BirthDate datetime,
	BirthLocation varchar(100),
	SISNumber varchar(11),
	SchoolName varchar(100),
	Sex char(1),
	Suffix varchar(20),
	fkCPRefClientEducationType decimal,
	EductionTypeDescription varchar(255),
	HomePhone varchar(10),
	CellPhone varchar(10),
	Email varchar(250)
)

DECLARE @RelatedMembers table
(
	pkMember decimal,
	pkRelatedMember decimal
)

DECLARE @MembersSyncItemType decimal(18,0) = 6;

INSERT INTO @PrimaryMembers
SELECT DISTINCT cl.pkCPClient,
	   cl.LastName,
	   cl.FirstName,
	   MiddleName = ISNULL(cl.MiddleName, ''),
	   cl.SSN,
	   StateIssuedNumber = ISNULL(cl.StateIssuedNumber, ''),
	   cl.NorthwoodsNumber,
	   MaidenName = ISNULL(cl.MaidenName, ''),
	   cl.BirthDate,
	   BirthLocation = ISNULL(cl.BirthLocation, ''),
	   SISNumber = ISNULL(cl.SISNumber, ''),
	   SchoolName = ISNULL(cl.SchoolName, ''),
	   cl.Sex,
	   Suffix = ISNULL(cl.Suffix, ''),
	   fkCPRefClientEducationType = ISNULL(cl.fkCPRefClientEducationType, -1),
	   EductionTypeDescription = ISNULL(cet.Description, ''),
	   HomePhone = ISNULL(cl.HomePhone, ''),
	   CellPhone = ISNULL(cl.CellPhone, ''),
	   Email = ISNULL(cl.Email, '')
FROM (SELECT cc.pkCPClientCase
	  FROM JoinEventTypeConnectType jevtr 
	  INNER JOIN EventType et ON jevtr.fkEventType = et.pkEventType
	  INNER JOIN CPClientCase cc ON cc.fkCPRefClientCaseProgramType = et.fkProgramType and @pkApplicationUser = cc.fkApplicationUser
	  WHERE jevtr.fkConnectType = @pkConnectType AND et.IncludeCaseworkerCases = 1

	  UNION

	  SELECT cc.pkCPClientCase
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
LEFT OUTER JOIN CPRefClientEducationType cet ON cet.pkCPRefClientEducationType = cl.fkCPRefClientEducationType

/* Related Members */

INSERT INTO @RelatedMembers
SELECT pm.pkCPClient, cjcr.fkCPClientParent
FROM @PrimaryMembers pm 
INNER JOIN CPJoinCPClientCPClientrefRelationship cjcr on cjcr.fkCPClientChild = pm.pkCPClient

UNION

SELECT pm.pkCPClient, cjcr.fkCPClientChild
FROM @PrimaryMembers pm 
INNER JOIN CPJoinCPClientCPClientrefRelationship cjcr on cjcr.fkCPClientParent = pm.pkCPClient

INSERT INTO @PrimaryMembers
SELECT cl.pkCPClient,
	   cl.LastName,
	   cl.FirstName,
	   MiddleName = ISNULL(cl.MiddleName, ''),
	   cl.SSN,
	   StateIssuedNumber = ISNULL(cl.StateIssuedNumber, ''),
	   cl.NorthwoodsNumber,
	   MaidenName = ISNULL(cl.MaidenName, ''),
	   cl.BirthDate,
	   BirthLocation = ISNULL(cl.BirthLocation, ''),
	   SISNumber = ISNULL(cl.SISNumber, ''),
	   SchoolName = ISNULL(cl.SchoolName, ''),
	   cl.Sex,
	   Suffix = ISNULL(cl.Suffix, ''),
	   fkCPRefClientEducationType = ISNULL(cl.fkCPRefClientEducationType, -1),
	   EductionTypeDescription = ISNULL(cet.Description, ''),
	   HomePhone = ISNULL(cl.HomePhone, ''),
	   CellPhone = ISNULL(cl.CellPhone, ''),
	   Email = ISNULL(cl.Email, '')
FROM CPClient cl WITH (NOLOCK)
LEFT JOIN CPJoinClientClientCase j WITH (NOLOCK) on j.fkCPClient = cl.pkCPClient
LEFT JOIN CPClientCase cc WITH (NOLOCK) on cc.pkCPClientCase = j.fkCPClientCase
LEFT OUTER JOIN CPRefClientEducationType cet ON cet.pkCPRefClientEducationType = cl.fkCPRefClientEducationType
WHERE cl.pkCPClient in (SELECT fkCPClientParent 
						FROM CPJoinCPClientCPClientrefRelationship cjcr (NOLOCK)
						join @PrimaryMembers pm on pm.pkCPClient = cjcr.fkCPClientChild)

UNION

SELECT cl.pkCPClient,
	   cl.LastName,
	   cl.FirstName,
	   MiddleName = ISNULL(cl.MiddleName, ''),
	   cl.SSN,
	   StateIssuedNumber = ISNULL(cl.StateIssuedNumber, ''),
	   cl.NorthwoodsNumber,
	   MaidenName = ISNULL(cl.MaidenName, ''),
	   cl.BirthDate,
	   BirthLocation = ISNULL(cl.BirthLocation, ''),
	   SISNumber = ISNULL(cl.SISNumber, ''),
	   SchoolName = ISNULL(cl.SchoolName, ''),
	   cl.Sex,
	   Suffix = ISNULL(cl.Suffix, ''),
	   fkCPRefClientEducationType = ISNULL(cl.fkCPRefClientEducationType, -1),
	   EductionTypeDescription = ISNULL(cet.Description, ''),
	   HomePhone = ISNULL(cl.HomePhone, ''),
	   CellPhone = ISNULL(cl.CellPhone, ''),
	   Email = ISNULL(cl.Email, '')
FROM CPClient cl WITH (NOLOCK)
LEFT JOIN CPJoinClientClientCase j WITH (NOLOCK) on j.fkCPClient = cl.pkCPClient
LEFT JOIN CPClientCase cc WITH (NOLOCK) on cc.pkCPClientCase = j.fkCPClientCase
LEFT OUTER JOIN CPRefClientEducationType cet ON cet.pkCPRefClientEducationType = cl.fkCPRefClientEducationType
WHERE cl.pkCPClient in (SELECT fkCPClientChild
						FROM CPJoinCPClientCPClientrefRelationship cjcr (NOLOCK)
						join @PrimaryMembers pm on pm.pkCPClient = cjcr.fkCPClientParent)

SELECT DISTINCT pm.*,
	   FormallyKnownAs = ISNULL(ccs.FormallyKnownAs, '')
FROM @PrimaryMembers pm
LEFT OUTER JOIN CompassCloudSyncItem ccs ON pm.pkCPClient = ccs.fkSyncItem AND ccs.SyncItemType = @MembersSyncItemType AND ccs.fkApplicationUser = @pkApplicationUser 

SELECT ca.pkCPClientAddress,
	   ca.fkCPRefClientAddressType,
	   Street1 = ISNULL(ca.Street1, ''),
	   Street2 = ISNULL(ca.Street2, ''),
	   Street3 = ISNULL(ca.Street3, ''),
	   ca.City,
	   ca.State,
	   ca.Zip,
	   ZipPlus4 = ISNULL(ca.ZipPlus4, ''),
	   ja.fkCPClient
FROM @PrimaryMembers m
INNER JOIN CPJoinClientClientAddress ja ON ja.fkCPClient = m.pkCPClient
INNER JOIN CPClientAddress ca ON ca.pkCPClientAddress = ja.fkCPClientAddress

select * from @RelatedMembers

SELECT ja.pkCPCaseActivity,
		ja.fkCPClientCase,
		ja.fkCPClient,	
		ja.CreateUser,
		ja.EffectiveCreateDate as CreateDate,
		ja.Description,
		FormerlyKnownAs = ISNULL(ccs.FormallyKnownAs, '')
FROM @PrimaryMembers pm
INNER JOIN CPCaseActivity ja ON ja.fkCPClient = pm.pkCPClient
LEFT OUTER JOIN CompassCloudSyncItem ccs ON ja.pkCPCaseActivity = ccs.fkSyncItem AND ccs.SyncItemType = 8 AND ccs.fkApplicationUser = @pkApplicationUser

;WITH    q AS 
			(
			SELECT  MergedMembers.*
			FROM    MergedMembers
			Inner Join @PrimaryMembers pm on pm.pkCPClient = MergedMembers.fkCPMergeMember
			UNION ALL
			SELECT  m.*
			FROM    MergedMembers m
			JOIN    q
			ON      m.fkCPMergeMember = q.fkCPDuplicateMember
			)

	SELECT q.fkCPMergeMember as MemberId, q.fkCPDuplicateMember as MergedFromId from q
	order by q.pkMergedMembers desc