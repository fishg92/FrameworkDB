




/* 
[usp_GetPermissionInfoForRole] 1

[usp_GetPermissionInfoForRole] -2

*/

CREATE PROC [dbo].[usp_GetPermissionInfoForRole]
(	@fkrefRole decimal
)
As


select 
DetailedDescription  
from refRole with (NOLOCK)
where pkrefRole = @fkrefRole and @fkrefRole > -2
and fkrefRoleType <> 1


select pkrefPermission
,Description =  ApplicationName + ' -> ' + TreeNode
 from refPermission  
innner join 
(select pkNCPApplication, ApplicationName from NCPApplication with (NOLOCK)
union
select -1, 'Pilot' 
) sq
on fkApplication = pkNCPApplication
where pkrefPermission in (select fkrefPermission from 
JoinrefRolerefPermission with (NOLOCK) where fkrefRole = @fkrefRole
and @fkrefRole > -2)

