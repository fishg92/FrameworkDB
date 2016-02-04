----------------------------------------------------------------------------
-- Update a single record in CPJoinCaseWorkerCaseWorkerPhone
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPJoinCaseWorkerCaseWorkerPhoneUpdate]
(	  @pkCPJoinCaseWorkerCaseWorkerPhone decimal(18, 0)
	, @fkCPCaseWorker decimal(18, 0) = NULL
	, @fkCPCaseWorkerPhone decimal(18, 0) = NULL
	, @fkCPRefPhoneType decimal (18,0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPJoinCaseWorkerCaseWorkerPhone
SET	fkCPCaseWorker = ISNULL(@fkCPCaseWorker, fkCPCaseWorker),
	fkCPCaseWorkerPhone = ISNULL(@fkCPCaseWorkerPhone, fkCPCaseWorkerPhone),
	fkCPRefPhoneType = ISNULL(@fkCPRefPhoneType, fkCPRefPhoneType)
WHERE 	pkCPJoinCaseWorkerCaseWorkerPhone = @pkCPJoinCaseWorkerCaseWorkerPhone
