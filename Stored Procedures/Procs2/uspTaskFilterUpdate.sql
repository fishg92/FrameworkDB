----------------------------------------------------------------------------
-- Update a single record in TaskFilter
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaskFilterUpdate]
(	  @pkTaskFilter decimal(18, 0)
	, @fkTaskView decimal(18, 0) = NULL
	, @TaskTab varchar(100) = NULL
	, @ParentNode varchar(100) = NULL
	, @Node varchar(100) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	TaskFilter
SET	fkTaskView = ISNULL(@fkTaskView, fkTaskView),
	TaskTab = ISNULL(@TaskTab, TaskTab),
	ParentNode = ISNULL(@ParentNode, ParentNode),
	Node = ISNULL(@Node, Node)
WHERE 	pkTaskFilter = @pkTaskFilter
