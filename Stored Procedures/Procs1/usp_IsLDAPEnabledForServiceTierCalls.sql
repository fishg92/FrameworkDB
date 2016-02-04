
create PROC [dbo].[usp_IsLDAPEnabledForServiceTierCalls]
AS
SELECT isnull((SELECT ItemValue As LDAPEnabled
FROM Configuration
WHERE ItemKey = 'LDAPEnabledForServiceCalls'), 0)
