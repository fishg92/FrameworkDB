
CREATE proc [dbo].[GetUsersDeltaForCloudSync]
(
	@pkApplicationUser decimal
)

As

/* User = 10 */

SELECT au.pkApplicationUser,
	   au.FirstName,
	   au.LastName,
	   FormallyKnownAs = ISNULL(ccs.FormallyKnownAs, '')
FROM ApplicationUser au LEFT OUTER JOIN 
(SELECT * 
  FROM CompassCloudSyncItem c
  WHERE c.SyncItemType = 10 AND c.fkApplicationUser = @pkApplicationUser) ccs ON ccs.fkSyncItem = au.pkApplicationUser
