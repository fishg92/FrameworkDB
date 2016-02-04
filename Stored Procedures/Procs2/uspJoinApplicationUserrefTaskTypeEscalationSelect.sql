----------------------------------------------------------------------------
-- Select a single record from JoinApplicationUserrefTaskTypeEscalation
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinApplicationUserrefTaskTypeEscalationSelect]
(	@pkJoinApplicationUserrefTaskTypeEscalation decimal(18, 0) = NULL,
	@fkrefTaskTypeEscalation decimal(18, 0) = NULL,
	@fkApplicationUser decimal(18, 0) = NULL
)
AS

SELECT	pkJoinApplicationUserrefTaskTypeEscalation,
	fkrefTaskTypeEscalation,
	fkApplicationUser
FROM	JoinApplicationUserrefTaskTypeEscalation
WHERE 	(@pkJoinApplicationUserrefTaskTypeEscalation IS NULL OR pkJoinApplicationUserrefTaskTypeEscalation = @pkJoinApplicationUserrefTaskTypeEscalation)
 AND 	(@fkrefTaskTypeEscalation IS NULL OR fkrefTaskTypeEscalation = @fkrefTaskTypeEscalation)
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)