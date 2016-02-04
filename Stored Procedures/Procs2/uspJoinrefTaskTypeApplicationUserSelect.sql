----------------------------------------------------------------------------
-- Select a single record from JoinrefTaskTypeApplicationUser
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinrefTaskTypeApplicationUserSelect]
(	@pkJoinrefTaskTypeApplicationUser decimal(18, 0) = NULL,
	@fkrefTaskType decimal(18, 0) = NULL,
	@fkApplicationUser decimal(18, 0) = NULL,
	@DisplayOrder int = NULL
)
AS

SELECT	pkJoinrefTaskTypeApplicationUser,
	fkrefTaskType,
	fkApplicationUser,
	DisplayOrder
FROM	JoinrefTaskTypeApplicationUser
WHERE 	(@pkJoinrefTaskTypeApplicationUser IS NULL OR pkJoinrefTaskTypeApplicationUser = @pkJoinrefTaskTypeApplicationUser)
 AND 	(@fkrefTaskType IS NULL OR fkrefTaskType = @fkrefTaskType)
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)
 AND 	(@DisplayOrder IS NULL OR DisplayOrder = @DisplayOrder)
