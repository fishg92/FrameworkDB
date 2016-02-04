



/* 
[usp_GetExtendedPermissionsInfo] 1
*/

CREATE PROC [dbo].[usp_GetExtendedPermissionsInfo]
(	@fkrefPermission decimal
)
As
SELECT Description from refRole with (NOLOCK) where pkrefRole in 
(select fkrefRole from JoinRefRoleRefPermission with (NOLOCK)
where fkrefPermission = @fkrefPermission)


  select distinct
		Fullname = Lastname + ', '+ FirstName 
        From  ApplicationUser a with (NOLOCK)
        inner join JoinApplicationUserrefRole j with (NOLOCK) 
		on fkApplicationUser = pkApplicationUser 
		inner join refRole r on pkrefRole = fkrefRole
		inner join dbo.JoinrefRolerefPermission jrp with (NOLOCK)
			on jrp.fkrefRole = pkRefRole
		--where pkrefRole in 
		--(select fkrefRole from  dbo.JoinrefRolerefPermission jrp with (NOLOCK)
		where fkrefPermission = @fkrefPermission --)
		
		

