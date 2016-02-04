----------------------------------------------------------------------------
-- Update a single record in CPCaseActivity
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPCaseActivityUpdate]
(	  @pkCPCaseActivity decimal(18, 0)
	, @fkCPCaseActivityType decimal(18, 0) = NULL
	, @fkCPClientCase decimal(18, 0) = NULL
	, @Description varchar(MAX) = NULL
	, @fkCPClient decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPCaseActivity
SET	fkCPCaseActivityType = ISNULL(@fkCPCaseActivityType, fkCPCaseActivityType),
	fkCPClientCase = ISNULL(@fkCPClientCase, fkCPClientCase),
	Description = ISNULL(@Description, Description),
	fkCPClient = ISNULL(@fkCPClient, fkCPClient)
WHERE 	pkCPCaseActivity = @pkCPCaseActivity
