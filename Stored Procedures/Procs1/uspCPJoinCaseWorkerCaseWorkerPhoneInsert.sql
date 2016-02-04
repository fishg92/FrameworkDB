----------------------------------------------------------------------------
-- Insert a single record into CPJoinCaseWorkerCaseWorkerPhone
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPJoinCaseWorkerCaseWorkerPhoneInsert]
(	  @fkCPCaseWorker decimal(18, 0) = NULL
	, @fkCPCaseWorkerPhone decimal(18, 0) = NULL
	, @fkCPRefPhoneType decimal (18,0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPJoinCaseWorkerCaseWorkerPhone decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPJoinCaseWorkerCaseWorkerPhone
(	  fkCPCaseWorker
	, fkCPCaseWorkerPhone
	, fkCPRefPhoneType
)
VALUES 
(	  @fkCPCaseWorker
	, @fkCPCaseWorkerPhone
	, @fkCPRefPhoneType

)

SET @pkCPJoinCaseWorkerCaseWorkerPhone = SCOPE_IDENTITY()
