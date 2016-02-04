
/* 
[usp_FrameworkGetExtendedUserInfo] 5
*/

CREATE PROC [dbo].[usp_FrameworkGetExtendedUserInfo]
(	@fkApplicationUser decimal
)
As
SELECT Description from refRole with (NOLOCK) where pkrefRole in 
(select fkrefRole from JoinApplicationUserrefRole with (NOLOCK)
where fkApplicationUser = @fkApplicationUser)

select Description from refPermission where pkrefPermission
in (select fkrefPermission from dbo.JoinrefRolerefPermission with (NOLOCK) 
inner join JoinApplicationUserrefRole j with (NOLOCK)
 on JoinrefRolerefPermission.fkrefRole = j.fkrefRole
where fkApplicationUser = @fkApplicationUser)
