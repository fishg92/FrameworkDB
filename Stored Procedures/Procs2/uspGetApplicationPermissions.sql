


-- [uspGetApplicationPermissions] -1


CREATE      procedure [dbo].[uspGetApplicationPermissions]
(	@fkApplication decimal
)
as

select distinct a.* from (
	select

	p.pkrefPermission
	,p.Description
	,p.EnumDescriptor
	,p.TreeGroup
	,p.TreeSubGroup
	,p.TreeNode
	,p.ParentRestriction
	,p.TreeNodeSeq

	from refPermission p with (NOLOCK) 
	inner join JoinrefRoleRefPermission jrp with (NOLOCK)
	on jrp.fkrefPermission = pkrefPermission
	--inner join joinrefRoleNCPApplication j with (NOLOCK) 
--	on jrp.fkrefRole = j.fkNCPApplication
	where fkApplication = @fkApplication
/*
	union

select
	p.pkrefPermission
	,p.Description
	,p.EnumDescriptor
	,p.TreeGroup
	,p.TreeSubGroup
	,p.TreeNode
	,p.ParentRestriction
	,p.TreeNodeSeq

	from refPermission p with (NOLOCK) 
	inner join JoinDefaultRoleRefPermission jrp with (NOLOCK)
	on jrp.fkrefPermission = pkrefPermission
	where @fkApplication = -1
*/
	) a




