
/*
EXEC usp_GetTaskView 1, -1
*/

CREATE PROC [dbo].[usp_GetTaskView]
(
	  @IsGlobal bit = 1
	, @fkApplicationUser decimal = -1
)
AS

SELECT	  pkTaskView
		, fkApplicationUser
		, ViewName
		, IsGlobal
FROM	TaskView
WHERE 	IsGlobal = @IsGlobal
AND		fkApplicationUser = @fkApplicationUser
ORDER BY	ViewName ASC

