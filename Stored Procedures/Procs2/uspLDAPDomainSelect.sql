----------------------------------------------------------------------------
-- Select a single record from LDAPDomain
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspLDAPDomainSelect]
(	@pkLDAPDomain int = NULL,
	@Domain varchar(255) = NULL,
	@LDAPUsername varchar(100) = NULL,
	@LDAPPassword varchar(100) = NULL
)
AS

SELECT	pkLDAPDomain,
	Domain,
	LDAPUsername,
	LDAPPassword
FROM	LDAPDomain
WHERE 	(@pkLDAPDomain IS NULL OR pkLDAPDomain = @pkLDAPDomain)
 AND 	(@Domain IS NULL OR Domain LIKE @Domain + '%')
 AND 	(@LDAPUsername IS NULL OR LDAPUsername LIKE @LDAPUsername + '%')
 AND 	(@LDAPPassword IS NULL OR LDAPPassword LIKE @LDAPPassword + '%')

