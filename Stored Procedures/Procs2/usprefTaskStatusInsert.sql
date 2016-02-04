----------------------------------------------------------------------------
-- Insert a single record into refTaskStatus
----------------------------------------------------------------------------
CREATE Proc [dbo].[usprefTaskStatusInsert]
(	  @Description varchar(50)
	, @TaskComplete bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkrefTaskStatus decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT refTaskStatus
(	  pkrefTaskStatus
	, Description
	, TaskComplete
)
VALUES 
(	  @pkrefTaskStatus
	, @Description
	, COALESCE(@TaskComplete, (0))

)

SET @pkrefTaskStatus = SCOPE_IDENTITY()
