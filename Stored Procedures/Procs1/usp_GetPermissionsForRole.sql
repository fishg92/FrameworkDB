
/* 
[usp_GetPermissionsForRole] 24

[usp_GetPermissionsForRole] -1

*/

CREATE PROC [dbo].[usp_GetPermissionsForRole]
(	@fkrefRole decimal
)
As
select 
pkrefRole
,Description
,DetailedDescription  
,fkrefRoleType
,LDAPGroupMatch = isnull(LDAPGroupMatch,0)
from refRole with (NOLOCK)
where pkrefRole = @fkrefRole and @fkrefRole <> -1

union 

select 
-1
,'New Role'
,'New Role'
,2
,0
where @fkrefRole = -1


select pkrefPermission
,TreeGroup
, TreeSubGroup
, TreeNodeSeq
, TreeNode
, Description
, fkApplication
, ParentRestriction
, ApplicationName = ''
, DetailedDescription
 from refPermission  with (NOLOCK)
left join ncpapplication (NOLOCK) n
	on fkApplication = n.pkNCPApplication
where (n.Registered = 1 or fkApplication = -1)



select
pkApplication = -1
, Description ='System'
union
select
pkApplication = pkNCPApplication
, ApplicationName
from NCPApplication with (NOLOCK)





SELECT pkJoinRefRoleRefPermission, fkrefRole, fkrefPermission from JoinRefRoleRefPermission with (NOLOCK)
where fkrefRole = @fkrefRole and @fkrefRole <> -1

select 
pkProfile
,Description
 from Profile with (NOLOCK)


select pkJoinrefRoleProfile
,fkrefRole
,fkProfile
 from joinrefroleProfile with (NOLOCK)
where fkrefRole = @fkrefRole and fkrefRole <> -1
