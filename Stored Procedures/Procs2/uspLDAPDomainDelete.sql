----------------------------------------------------------------------------
-- Delete a single record from LDAPDomain
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspLDAPDomainDelete]
(	@pkLDAPDomain int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	LDAPDomain
WHERE 	pkLDAPDomain = @pkLDAPDomain
