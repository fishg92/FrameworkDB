-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from JoinApplicationUserrefRole
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinApplicationUserrefRoleDelete]
(	@pkJoinApplicationUserrefRole decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

/* Temporarily delete all like Joins until it is determined how dupe joins are getting here to being with */
declare @fkrefRole decimal
declare @fkApplicationUser decimal

select @fkrefRole = fkrefRole
, @fkApplicationUser = fkApplicationUser
from JoinApplicationUserrefRole
WHERE 	pkJoinApplicationUserrefRole = @pkJoinApplicationUserrefRole

DELETE	JoinApplicationUserrefRole
WHERE 	fkrefRole = @fkrefRole
and fkApplicationUser =  @fkApplicationUser 

DELETE	JoinApplicationUserrefRole
WHERE 	pkJoinApplicationUserrefRole = @pkJoinApplicationUserrefRole
