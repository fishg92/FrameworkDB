
--select * from dbo.TaskCategoryBranch (6)

CREATE  function TaskCategoryBranch(@pkrefTaskCategory decimal(18,0))

RETURNS TABLE AS RETURN (
WITH TaskCategoryBranch (pkrefTaskCategory, fkrefTaskCategoryParent,[Level]) AS
(
	SELECT pkrefTaskCategory, fkrefTaskCategoryParent, 0 AS [Level]
		FROM refTaskCategory
	WHERE pkrefTaskCategory = @pkrefTaskCategory
	UNION ALL

	SELECT Child.pkrefTaskCategory
		, Child.fkrefTaskCategoryParent
		, TaskCategoryBranch.[Level] + 1
	FROM refTaskCategory AS Child
	INNER JOIN TaskCategoryBranch ON 
	TaskCategoryBranch.pkrefTaskCategory = Child.fkrefTaskCategoryParent
)
SELECT pkrefTaskCategory FROM TaskCategoryBranch
)