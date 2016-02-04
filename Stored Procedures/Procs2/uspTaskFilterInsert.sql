----------------------------------------------------------------------------
-- Insert a single record into TaskFilter
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspTaskFilterInsert]
(	  @fkTaskView decimal(18, 0) = NULL
	, @TaskTab varchar(100) = NULL
	, @ParentNode varchar(100) = NULL
	, @Node varchar(100) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkTaskFilter decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT TaskFilter
(	  fkTaskView
	, TaskTab
	, ParentNode
	, Node
)
VALUES 
(	  @fkTaskView
	, @TaskTab
	, @ParentNode
	, @Node

)

SET @pkTaskFilter = SCOPE_IDENTITY()
