----------------------------------------------------------------------------
-- Delete a single record from CPClientCase
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPClientCaseDelete]
(	@pkCPClientCase decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	CPClientCase
WHERE 	pkCPClientCase = @pkCPClientCase
