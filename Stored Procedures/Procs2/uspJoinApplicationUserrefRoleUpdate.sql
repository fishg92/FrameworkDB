-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in JoinApplicationUserrefRole
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinApplicationUserrefRoleUpdate]
(	  @pkJoinApplicationUserrefRole decimal(18, 0)
	, @fkApplicationUser decimal(18, 0) = NULL
	, @fkrefRole decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinApplicationUserrefRole
SET	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser),
	fkrefRole = ISNULL(@fkrefRole, fkrefRole)
WHERE 	pkJoinApplicationUserrefRole = @pkJoinApplicationUserrefRole
