----------------------------------------------------------------------------
-- Insert a single record into CPJoinCaseWorkerAgencyAddress
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPJoinCaseWorkerAgencyAddressInsert]
(	  @fkCPCaseWorker decimal(18, 0) = NULL
	, @fkCPAgencyAddress decimal(18, 0) = NULL
	, @fkCPRefAgencyAddressType decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPJoinCaseWorkerAgencyAddress decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPJoinCaseWorkerAgencyAddress
(	  fkCPCaseWorker
	, fkCPAgencyAddress
	, fkCPRefAgencyAddressType
)
VALUES 
(	  @fkCPCaseWorker
	, @fkCPAgencyAddress
	, @fkCPRefAgencyAddressType

)

SET @pkCPJoinCaseWorkerAgencyAddress = SCOPE_IDENTITY()
