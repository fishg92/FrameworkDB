-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from JoinApplicationUserRefCredentialType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinApplicationUserRefCredentialTypeDelete]
(	@pkJoinApplicationUserRefCredentialType decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	JoinApplicationUserRefCredentialType
WHERE 	pkJoinApplicationUserRefCredentialType = @pkJoinApplicationUserRefCredentialType
