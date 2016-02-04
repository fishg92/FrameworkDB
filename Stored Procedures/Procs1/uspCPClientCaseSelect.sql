----------------------------------------------------------------------------
-- Select a single record from CPClientCase
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPClientCaseSelect]
(	@pkCPClientCase decimal(18, 0) = NULL,
	@StateCaseNumber varchar(20) = NULL,
	@LocalCaseNumber varchar(20) = NULL,
	@fkCPRefClientCaseProgramType decimal(18, 0) = NULL,
	@fkCPCaseWorker decimal(18, 0) = NULL,
	@LockedUser varchar(50) = NULL,
	@LockedDate datetime = NULL,
	@fkCPClientCaseHead decimal(18, 0) = NULL,
	@fkApplicationUser decimal(18, 0) = NULL,
	@DistrictId varchar(50) = NULL
)
AS

SELECT	pkCPClientCase,
	StateCaseNumber,
	LocalCaseNumber,
	fkCPRefClientCaseProgramType,
	fkCPCaseWorker,
	LockedUser,
	LockedDate,
	fkCPClientCaseHead,
	fkApplicationUser,
	DistrictId
FROM	CPClientCase
WHERE 	(@pkCPClientCase IS NULL OR pkCPClientCase = @pkCPClientCase)
 AND 	(@StateCaseNumber IS NULL OR StateCaseNumber LIKE @StateCaseNumber + '%')
 AND 	(@LocalCaseNumber IS NULL OR LocalCaseNumber LIKE @LocalCaseNumber + '%')
 AND 	(@fkCPRefClientCaseProgramType IS NULL OR fkCPRefClientCaseProgramType = @fkCPRefClientCaseProgramType)
 AND 	(@fkCPCaseWorker IS NULL OR fkCPCaseWorker = @fkCPCaseWorker)
 AND 	(@LockedUser IS NULL OR LockedUser LIKE @LockedUser + '%')
 AND 	(@LockedDate IS NULL OR LockedDate = @LockedDate)
 AND 	(@fkCPClientCaseHead IS NULL OR fkCPClientCaseHead = @fkCPClientCaseHead)
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)
 AND 	(@DistrictId IS NULL OR DistrictId LIKE @DistrictId + '%')
