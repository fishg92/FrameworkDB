CREATE PROC [dbo].[usp_IsLDAPEnabled]
AS
SELECT isnull((SELECT ItemValue As LDAPEnabled
FROM Configuration
WHERE ItemKey = 'LDAPEnabled'), 0)