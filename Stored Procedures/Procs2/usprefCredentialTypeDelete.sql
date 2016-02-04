-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from RefCredentialType
----------------------------------------------------------------------------
CREATE Proc [dbo].[usprefCredentialTypeDelete]
(	@pkRefCredentialType decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	RefCredentialType
WHERE 	pkRefCredentialType = @pkRefCredentialType
