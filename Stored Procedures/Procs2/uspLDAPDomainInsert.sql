----------------------------------------------------------------------------
-- Insert a single record into LDAPDomain
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspLDAPDomainInsert]
(	  @Domain varchar(255)
	, @LDAPUsername varchar(100) = NULL
	, @LDAPPassword varchar(100) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkLDAPDomain int = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT LDAPDomain
(	  Domain
	, LDAPUsername
	, LDAPPassword
)
VALUES 
(	  @Domain
	, @LDAPUsername
	, @LDAPPassword

)

SET @pkLDAPDomain = SCOPE_IDENTITY()
