



/*
 [uspHasPermission] 2, 2, 'CanRunFormsDesigner'
*/

CREATE      procedure [dbo].[uspHasPermission] 
(@fkApplicationUser decimal
,@fkApplication decimal
,@Descriptor varchar(100)
)
as

select case when exists(
	select top 1 1 from refPermission p with (NOLOCK)
	inner join JoinrefRoleRefPermission jrp with (NOLOCK)
	on jrp.fkrefPermission = pkrefPermission
	inner join JoinApplicationUserrefRole ja with (NOLOCK)
	on ja.fkApplicationUser = fkApplicationUser
	and jrp.fkrefRole = ja.fkrefRole
	where fkApplicationUser = @fkApplicationUser
	and EnumDescriptor = @Descriptor
	and  @fkApplication in (-1,fkApplication)

	union

	select top 1 1 from refPermission p with (NOLOCK)
	inner join JoinDefaultRoleRefPermission jrp with (NOLOCK)
	on jrp.fkrefPermission = pkrefPermission
	inner join ApplicationUserDefaultRoleAssignment ja with (NOLOCK)
	on ja.fkApplicationUser = fkApplicationUser
		where fkApplicationUser = @fkApplicationUser
	and EnumDescriptor = @Descriptor
	and @fkApplication = -1

) then 1 else 0 end







