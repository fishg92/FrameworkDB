----------------------------------------------------------------------------
-- Select a single record from JoinApplicationUserSecureGroup
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinApplicationUserSecureGroupSelect]
(	@pkJoinApplicationUserSecureGroup decimal(18, 0) = NULL,
	@fkApplicationUser decimal(18, 0) = NULL,
	@fkLockedEntity decimal(18, 0) = NULL
)
AS

SELECT	pkJoinApplicationUserSecureGroup,
	fkApplicationUser,
	fkLockedEntity
FROM	JoinApplicationUserSecureGroup
WHERE 	(@pkJoinApplicationUserSecureGroup IS NULL OR pkJoinApplicationUserSecureGroup = @pkJoinApplicationUserSecureGroup)
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)
 AND 	(@fkLockedEntity IS NULL OR fkLockedEntity = @fkLockedEntity)