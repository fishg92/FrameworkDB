----------------------------------------------------------------------------
-- Update a single record in CPCaseWorkerAltId
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPCaseWorkerAltIdUpdate]
(	  @pkCPCaseWorkerAltId decimal(18, 0)
	, @fkCPCaseWorker decimal(18, 0) = NULL
	, @WorkerId varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @LockedUser varchar(50) = NULL
	, @fkApplicationUser decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPCaseWorkerAltId
SET	fkCPCaseWorker = ISNULL(@fkCPCaseWorker, fkCPCaseWorker),
	WorkerId = ISNULL(@WorkerId, WorkerId),
	LockedDate = ISNULL(@LockedDate, LockedDate),
	LockedUser = ISNULL(@LockedUser, LockedUser),
	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser)
WHERE 	pkCPCaseWorkerAltId = @pkCPCaseWorkerAltId
