CREATE proc [dbo].[GetFavoriteTaskTypesForUser]
	@fkApplicationUser decimal
as

select	pkJoinrefTaskTypeApplicationUser
		, fkrefTaskType
		, fkApplicationUser
		, DisplayOrder
from	dbo.JoinrefTaskTypeApplicationUser
where fkApplicationUser = @fkApplicationUser
order by DisplayOrder