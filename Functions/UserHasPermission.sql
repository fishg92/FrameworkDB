CREATE FUNCTION [dbo].[UserHasPermission]
	(@pkApplicationUser decimal
	,@pkrefPermission decimal)
RETURNS bit
AS
BEGIN
declare @ret bit
set @ret = 0

if exists (	select	*
			from	JoinApplicationUserrefRole
			join JoinrefRolerefPermission
				on JoinApplicationUserrefRole.fkrefRole = JoinrefRolerefPermission.fkrefRole
			where JoinApplicationUserrefRole.fkApplicationUser = @pkApplicationUser
			and JoinrefRolerefPermission.fkrefPermission = @pkrefPermission)
	set @ret = 1
	
	RETURN @ret
END



