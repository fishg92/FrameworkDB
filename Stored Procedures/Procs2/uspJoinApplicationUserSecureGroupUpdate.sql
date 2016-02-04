----------------------------------------------------------------------------
-- Update a single record in JoinApplicationUserSecureGroup
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinApplicationUserSecureGroupUpdate]
(	  @pkJoinApplicationUserSecureGroup decimal(18, 0)
	, @fkApplicationUser decimal(18, 0) = NULL
	, @fkLockedEntity decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinApplicationUserSecureGroup
SET	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser),
	fkLockedEntity = ISNULL(@fkLockedEntity, fkLockedEntity)
WHERE 	pkJoinApplicationUserSecureGroup = @pkJoinApplicationUserSecureGroup
