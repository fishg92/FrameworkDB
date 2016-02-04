
/*
EXEC usp_GetTaskFiltersByView 1
SELECT * FROM TaskFilter
*/

CREATE PROC [dbo].[usp_GetTaskFiltersByView]
(
	@fkTaskView decimal(18,0)
)
AS

SELECT	
		tf.fkTaskView
		, tf.TaskTab
		, tf.ParentNode
		, tf.Node
FROM	TaskFilter AS tf (NOLOCK)
INNER JOIN TaskView AS tv ON tv.pkTaskView = tf.fkTaskView
WHERE 	tf.fkTaskView = @fkTaskView

SELECT DISTINCT
		ParentNode
FROM	TaskFilter
WHERE 	fkTaskView = @fkTaskView

SELECT
		  ISNULL(ShowUnread, 0) AS ShowUnread
		, ISNULL(IgnoreFilters, 0) AS IgnoreFilters
		, ISNULL(IncludeCompleted, 0) AS IncludeCompleted
		, CompletedDate
FROM	TaskView
WHERE	pkTaskView = @fkTaskView