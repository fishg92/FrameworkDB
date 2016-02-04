----------------------------------------------------------------------------
-- Update a single record in LDAPDomain
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspLDAPDomainUpdate]
(	  @pkLDAPDomain int
	, @Domain varchar(255) = NULL
	, @LDAPUsername varchar(100) = NULL
	, @LDAPPassword varchar(100) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	LDAPDomain
SET	Domain = ISNULL(@Domain, Domain),
	LDAPUsername = ISNULL(@LDAPUsername, LDAPUsername),
	LDAPPassword = ISNULL(@LDAPPassword, LDAPPassword)
WHERE 	pkLDAPDomain = @pkLDAPDomain
