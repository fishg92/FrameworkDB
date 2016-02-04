----------------------------------------------------------------------------
-- Insert a single record into refRole
----------------------------------------------------------------------------
CREATE Proc [dbo].[usprefRoleInsert]
(	  @Description varchar(255)
	, @DetailedDescription varchar(2500) = NULL
	, @fkrefRoleType decimal(18, 0) = NULL
	, @LDAPGroupMatch bit = NULL
	, @LDAPDomainName varchar(100) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkrefRole decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT refRole
(	  Description
	, DetailedDescription
	, fkrefRoleType
	, LDAPGroupMatch
	, LDAPDomainName
)
VALUES 
(	  @Description
	, @DetailedDescription
	, @fkrefRoleType
	, @LDAPGroupMatch
	, @LDAPDomainName

)

SET @pkrefRole = SCOPE_IDENTITY()
