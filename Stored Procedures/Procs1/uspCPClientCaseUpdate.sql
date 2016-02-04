----------------------------------------------------------------------------
-- Update a single record in CPClientCase
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPClientCaseUpdate]
(	  @pkCPClientCase decimal(18, 0)
	, @StateCaseNumber varchar(20) = NULL
	, @LocalCaseNumber varchar(20) = NULL
	, @fkCPRefClientCaseProgramType decimal(18, 0) = NULL
	, @fkCPCaseWorker decimal(18, 0) = NULL
	, @LockedUser varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @fkCPClientCaseHead decimal(18, 0) = NULL
	, @fkApplicationUser decimal(18, 0) = NULL
	, @DistrictId varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPClientCase
SET	StateCaseNumber = ISNULL(@StateCaseNumber, StateCaseNumber),
	LocalCaseNumber = ISNULL(@LocalCaseNumber, LocalCaseNumber),
	fkCPRefClientCaseProgramType = ISNULL(@fkCPRefClientCaseProgramType, fkCPRefClientCaseProgramType),
	fkCPCaseWorker = ISNULL(@fkCPCaseWorker, fkCPCaseWorker),
	LockedUser = ISNULL(@LockedUser, LockedUser),
	LockedDate = ISNULL(@LockedDate, LockedDate),
	fkCPClientCaseHead = ISNULL(@fkCPClientCaseHead, fkCPClientCaseHead),
	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser),
	DistrictId = ISNULL(@DistrictId, DistrictId)
WHERE 	pkCPClientCase = @pkCPClientCase
