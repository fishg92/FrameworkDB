----------------------------------------------------------------------------
-- Select a single record from TaskFilter
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaskFilterSelect]
(	@pkTaskFilter decimal(18, 0) = NULL,
	@fkTaskView decimal(18, 0) = NULL,
	@TaskTab varchar(100) = NULL,
	@ParentNode varchar(100) = NULL,
	@Node varchar(100) = NULL
)
AS

SELECT	pkTaskFilter,
	fkTaskView,
	TaskTab,
	ParentNode,
	Node
FROM	TaskFilter
WHERE 	(@pkTaskFilter IS NULL OR pkTaskFilter = @pkTaskFilter)
 AND 	(@fkTaskView IS NULL OR fkTaskView = @fkTaskView)
 AND 	(@TaskTab IS NULL OR TaskTab LIKE @TaskTab + '%')
 AND 	(@ParentNode IS NULL OR ParentNode LIKE @ParentNode + '%')
 AND 	(@Node IS NULL OR Node LIKE @Node + '%')
