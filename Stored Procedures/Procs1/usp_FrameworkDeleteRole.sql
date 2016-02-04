




/* 
[usp_FrameworkDeleteRole] 5
*/

CREATE PROC [dbo].[usp_FrameworkDeleteRole]
(	@pkrefRole decimal
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
As

exec dbo.SetAuditDataContext @LupUser, @LupMachine

delete from JoinrefRolerefPermission where fkrefRole = @pkrefRole

delete from JoinApplicationUserrefRole where fkrefRole = @pkrefRole

delete from JoinrefRoleProfile where fkrefRole = @pkrefRole

delete from refRole where pkrefRole = @pkrefRole
