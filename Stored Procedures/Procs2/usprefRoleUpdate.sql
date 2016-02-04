----------------------------------------------------------------------------
-- Update a single record in refRole
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefRoleUpdate]
(	  @pkrefRole decimal(18, 0)
	, @Description varchar(255) = NULL
	, @DetailedDescription varchar(2500) = NULL
	, @fkrefRoleType decimal(18, 0) = NULL
	, @LDAPGroupMatch bit = NULL
	, @LDAPDomainName varchar(100) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	refRole
SET	Description = ISNULL(@Description, Description),
	DetailedDescription = ISNULL(@DetailedDescription, DetailedDescription),
	fkrefRoleType = ISNULL(@fkrefRoleType, fkrefRoleType),
	LDAPGroupMatch = ISNULL(@LDAPGroupMatch, LDAPGroupMatch),
	LDAPDomainName = ISNULL(@LDAPDomainName, LDAPDomainName)
WHERE 	pkrefRole = @pkrefRole
