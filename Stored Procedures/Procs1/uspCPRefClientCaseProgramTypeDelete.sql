----------------------------------------------------------------------------
-- Delete a single record from CPRefClientCaseProgramType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPRefClientCaseProgramTypeDelete]
(	@pkCPRefClientCaseProgramType decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	CPRefClientCaseProgramType
WHERE 	pkCPRefClientCaseProgramType = @pkCPRefClientCaseProgramType
