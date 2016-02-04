----------------------------------------------------------------------------
-- Insert a single record into CPCaseWorkerAltId
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPCaseWorkerAltIdInsert]
(	  @fkCPCaseWorker decimal(18, 0) = NULL
	, @WorkerId varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @LockedUser varchar(50) = NULL
	, @fkApplicationUser decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPCaseWorkerAltId decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPCaseWorkerAltId
(	  fkCPCaseWorker
	, WorkerId
	, LockedDate
	, LockedUser
	, fkApplicationUser
)
VALUES 
(	  @fkCPCaseWorker
	, @WorkerId
	, @LockedDate
	, @LockedUser
	, @fkApplicationUser

)

SET @pkCPCaseWorkerAltId = SCOPE_IDENTITY()
