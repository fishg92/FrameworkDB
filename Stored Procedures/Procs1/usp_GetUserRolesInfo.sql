
--[usp_GetUserRolesInfo] 1

CREATE PROC [dbo].[usp_GetUserRolesInfo]
(	@fkApplicationUser decimal
)
As

--Table 0
select	pkrefRole
		,Description
		,LDAPGroupMatch = isnull(LDAPGroupMatch,0)
from refRole with (NOLOCK)

--Table 1
select	pkJoinApplicationUserrefRole
		,fkApplicationUser
		,fkrefRole
from JoinApplicationUserrefRole with (NOLOCK)
where fkApplicationUser = @fkApplicationUser

