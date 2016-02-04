----------------------------------------------------------------------------
-- Select a single record from CPJoinCaseWorkerCaseWorkerPhone
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPJoinCaseWorkerCaseWorkerPhoneSelect]
(	@pkCPJoinCaseWorkerCaseWorkerPhone decimal(18, 0) = NULL,
	@fkCPCaseWorker decimal(18, 0) = NULL,
	@fkCPCaseWorkerPhone decimal(18, 0) = NULL,
	@fkCPRefPhoneType decimal(18,0) = NULL
)
AS

SELECT	pkCPJoinCaseWorkerCaseWorkerPhone,
	fkCPCaseWorker,
	fkCPCaseWorkerPhone,
	fkCPRefPhoneType
FROM	CPJoinCaseWorkerCaseWorkerPhone
WHERE 	(@pkCPJoinCaseWorkerCaseWorkerPhone IS NULL OR pkCPJoinCaseWorkerCaseWorkerPhone = @pkCPJoinCaseWorkerCaseWorkerPhone)
 AND 	(@fkCPCaseWorker IS NULL OR fkCPCaseWorker = @fkCPCaseWorker)
 AND 	(@fkCPCaseWorkerPhone IS NULL OR fkCPCaseWorkerPhone = @fkCPCaseWorkerPhone)
 AND 	(@fkCPRefPhoneType IS NULL OR fkCPRefPhoneType = @fkCPRefPhoneType)

