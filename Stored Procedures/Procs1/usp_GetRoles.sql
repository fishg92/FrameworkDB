
/* 
[usp_GetRoles] 
*/

CREATE PROC [dbo].[usp_GetRoles]

As
SELECT pkrefRole, Description, LDAPGroupMatch from refRole with (NOLOCK)
where isnull(fkrefRoleType,-1) <> 1
