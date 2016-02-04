
CREATE proc [dbo].[GetPreferencesDeltaForCloudSync]
(
	@pkApplicationUser decimal
)

AS

/* Preference = 17 */

SELECT c.pkConfiguration,
	   c.ItemKey,
	   ItemValue = ISNULL(NULLIF(c.ItemValue,''),'000000000L'),
	   ItemDescription = ISNULL(c.ItemDescription, ''),
	   FormallyKnownAs = ISNULL(ccs.FormallyKnownAs, '')
FROM Configuration c LEFT OUTER JOIN 
 (SELECT * 
  FROM CompassCloudSyncItem cs
  WHERE cs.SyncItemType = 17 AND cs.fkApplicationUser = @pkApplicationUser) ccs ON ccs.fkSyncItem = c.pkConfiguration
  WHERE (c.ItemKey = 'StateIDMask' AND AppID = 9) OR 
        (c.ItemKey like 'SSNException%' AND AppID = 9)
