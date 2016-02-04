
CREATE proc [dbo].[GetEducationTypesDeltaForCloudSync]
(
	@pkApplicationUser decimal
)

As

/* Education Type = 16 */

SELECT et.pkCPRefClientEducationType,
    et.Description,
    FormallyKnownAs = ISNULL(ccs.FormallyKnownAs, '')
FROM CPRefClientEducationType et LEFT OUTER JOIN 
 (SELECT * 
  FROM CompassCloudSyncItem c
  WHERE c.SyncItemType = 16 AND c.fkApplicationUser = @pkApplicationUser) ccs ON ccs.fkSyncItem = et.pkCPRefClientEducationType
