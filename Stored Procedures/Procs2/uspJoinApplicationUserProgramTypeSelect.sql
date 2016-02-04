----------------------------------------------------------------------------
-- Select a single record from JoinApplicationUserProgramType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinApplicationUserProgramTypeSelect]
(	@pkJoinApplicationUserProgramType decimal(18, 0) = NULL,
	@fkApplicationUser decimal(18, 0) = NULL,
	@fkProgramType decimal(18, 0) = NULL
)
AS

SELECT	pkJoinApplicationUserProgramType,
	fkApplicationUser,
	fkProgramType
FROM	JoinApplicationUserProgramType
WHERE 	(@pkJoinApplicationUserProgramType IS NULL OR pkJoinApplicationUserProgramType = @pkJoinApplicationUserProgramType)
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)
 AND 	(@fkProgramType IS NULL OR fkProgramType = @fkProgramType)
