----------------------------------------------------------------------------
-- Select a single record from CPJoinCaseWorkerAgencyAddress
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPJoinCaseWorkerAgencyAddressSelect]
(	@pkCPJoinCaseWorkerAgencyAddress decimal(18, 0) = NULL,
	@fkCPCaseWorker decimal(18, 0) = NULL,
	@fkCPAgencyAddress decimal(18, 0) = NULL,
	@fkCPRefAgencyAddressType decimal(18, 0) = NULL
)
AS

SELECT	pkCPJoinCaseWorkerAgencyAddress,
	fkCPCaseWorker,
	fkCPAgencyAddress,
	fkCPRefAgencyAddressType
FROM	CPJoinCaseWorkerAgencyAddress
WHERE 	(@pkCPJoinCaseWorkerAgencyAddress IS NULL OR pkCPJoinCaseWorkerAgencyAddress = @pkCPJoinCaseWorkerAgencyAddress)
 AND 	(@fkCPCaseWorker IS NULL OR fkCPCaseWorker = @fkCPCaseWorker)
 AND 	(@fkCPAgencyAddress IS NULL OR fkCPAgencyAddress = @fkCPAgencyAddress)
 AND 	(@fkCPRefAgencyAddressType IS NULL OR fkCPRefAgencyAddressType = @fkCPRefAgencyAddressType)

