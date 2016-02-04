----------------------------------------------------------------------------
-- Select a single record from refRole
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefRoleSelect]
(	@pkrefRole decimal(18, 0) = NULL,
	@Description varchar(255) = NULL,
	@DetailedDescription varchar(2500) = NULL,
	@fkrefRoleType decimal(18, 0) = NULL,
	@LDAPGroupMatch bit = NULL,
	@LDAPDomainName varchar(100) = NULL
)
AS

SELECT	pkrefRole,
	Description,
	DetailedDescription,
	fkrefRoleType,
	LDAPGroupMatch,
	LDAPDomainName
FROM	refRole
WHERE 	(@pkrefRole IS NULL OR pkrefRole = @pkrefRole)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')
 AND 	(@DetailedDescription IS NULL OR DetailedDescription LIKE @DetailedDescription + '%')
 AND 	(@fkrefRoleType IS NULL OR fkrefRoleType = @fkrefRoleType)
 AND 	(@LDAPGroupMatch IS NULL OR LDAPGroupMatch = @LDAPGroupMatch)
 AND 	(@LDAPDomainName IS NULL OR LDAPDomainName LIKE @LDAPDomainName + '%')

