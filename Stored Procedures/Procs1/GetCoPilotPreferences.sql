
-- Stored Procedure

/*
exec GetCoPilotPreferences
*/
CREATE PROCEDURE [dbo].[GetCoPilotPreferences]

AS
BEGIN
	SET NOCOUNT ON;

select 
  pk = pkConfiguration
, itemKey
, itemValue = isnull(itemValue,'')
, itemDescription = isnull(itemDescription, '') 
, tableName = 'Configuration'
from configuration
where itemkey = 'StateIDMask'
	AND AppID = 9

END




