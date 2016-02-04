-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from JoinrefRoleProfile
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinrefRoleProfileDelete]
(	@pkJoinrefRoleProfile decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	JoinrefRoleProfile
WHERE 	pkJoinrefRoleProfile = @pkJoinrefRoleProfile
