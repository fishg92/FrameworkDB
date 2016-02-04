----------------------------------------------------------------------------
-- Update a single record in CPJoinCaseWorkerAgencyAddress
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPJoinCaseWorkerAgencyAddressUpdate]
(	  @pkCPJoinCaseWorkerAgencyAddress decimal(18, 0)
	, @fkCPCaseWorker decimal(18, 0) = NULL
	, @fkCPAgencyAddress decimal(18, 0) = NULL
	, @fkCPRefAgencyAddressType decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPJoinCaseWorkerAgencyAddress
SET	fkCPCaseWorker = ISNULL(@fkCPCaseWorker, fkCPCaseWorker),
	fkCPAgencyAddress = ISNULL(@fkCPAgencyAddress, fkCPAgencyAddress),
	fkCPRefAgencyAddressType = ISNULL(@fkCPRefAgencyAddressType, fkCPRefAgencyAddressType)
WHERE 	pkCPJoinCaseWorkerAgencyAddress = @pkCPJoinCaseWorkerAgencyAddress
