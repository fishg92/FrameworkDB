
--[dbo].[uspGetAllPermissions] 

CREATE      procedure [dbo].[uspGetAllPermissions] 
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
	,p.fkApplication
	,Appid = ap.pkNCPApplication

	from refPermission p with (NOLOCK) 
	inner join NCPApplication ap on fkApplication  = pkNCPApplication

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
	,p.fkApplication
	,AppID = -1

	from refPermission p with (NOLOCK) 
	where fkApplication = -1

	) a
