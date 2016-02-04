


--uspGetApplicationUserSecurityVerifyInfo

CREATE PROC [dbo].[uspGetApplicationUserSecurityVerifyInfo]
As
Select
	pkApplicationUser 
	, Password
FROM dbo.ApplicationUser (NOLOCK)

select 
pkJoinApplicationUserrefCredentialType 
,Password
from JoinApplicationUserrefCredentialType (NOLOCK)
