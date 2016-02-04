----------------------------------------------------------------------------
-- Delete a single record from CPCaseActivityType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPCaseActivityTypeDelete]
(	@pkCPCaseActivityType decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	CPCaseActivityType
WHERE 	pkCPCaseActivityType = @pkCPCaseActivityType
