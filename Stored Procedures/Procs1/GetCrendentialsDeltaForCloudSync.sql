

CREATE proc [dbo].[GetCrendentialsDeltaForCloudSync]
(
	@pkApplicationUser decimal
)

As

/* Credential = 15 */

SELECT au.pkApplicationUser,
	   au.FirstName,
	   au.LastName,
	   FormallyKnownAs = ISNULL(ccs.FormallyKnownAs, '')
FROM ApplicationUser au LEFT OUTER JOIN 
(SELECT * 
  FROM CompassCloudSyncItem c
  WHERE c.SyncItemType = 15 AND c.fkApplicationUser = @pkApplicationUser) ccs ON ccs.fkSyncItem = cast(au.pkApplicationUser as varchar)
WHERE au.pkApplicationUser = @pkApplicationUser
