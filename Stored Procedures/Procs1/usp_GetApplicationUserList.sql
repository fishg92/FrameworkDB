
CREATE PROC [dbo].[usp_GetApplicationUserList]
As
Select
	pkApplicationUser 
	, LastName + ', ' + FirstName As Name
	, UserName
	, LDAPUser
FROM dbo.ApplicationUser
