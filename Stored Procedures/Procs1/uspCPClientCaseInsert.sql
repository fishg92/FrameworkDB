----------------------------------------------------------------------------
-- Insert a single record into CPClientCase
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPClientCaseInsert]
(	  @StateCaseNumber varchar(20) = NULL
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
	, @pkCPClientCase decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPClientCase
(	  StateCaseNumber
	, LocalCaseNumber
	, fkCPRefClientCaseProgramType
	, fkCPCaseWorker
	, LockedUser
	, LockedDate
	, fkCPClientCaseHead
	, fkApplicationUser
	, DistrictId
)
VALUES 
(	  @StateCaseNumber
	, @LocalCaseNumber
	, @fkCPRefClientCaseProgramType
	, @fkCPCaseWorker
	, @LockedUser
	, @LockedDate
	, @fkCPClientCaseHead
	, @fkApplicationUser
	, @DistrictId

)

SET @pkCPClientCase = SCOPE_IDENTITY()
