----------------------------------------------------------------------------
-- Update a single record in JoinrefTaskTypeApplicationUser
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinrefTaskTypeApplicationUserUpdate]
(	  @pkJoinrefTaskTypeApplicationUser decimal(18, 0)
	, @fkrefTaskType decimal(18, 0) = NULL
	, @fkApplicationUser decimal(18, 0) = NULL
	, @DisplayOrder int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinrefTaskTypeApplicationUser
SET	fkrefTaskType = ISNULL(@fkrefTaskType, fkrefTaskType),
	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser),
	DisplayOrder = ISNULL(@DisplayOrder, DisplayOrder)
WHERE 	pkJoinrefTaskTypeApplicationUser = @pkJoinrefTaskTypeApplicationUser
