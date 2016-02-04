





/* 
uspGetRolesForProfile 1
*/

create PROC [dbo].[uspGetRolesForProfile]
(	@fkProfile decimal
)
As
SELECT * from refRole with (NOLOCK) 
	where pkrefRole in 
(select fkrefRole from JoinrefRoleProfile where fkProfile in (@fkProfile,-1)
)

