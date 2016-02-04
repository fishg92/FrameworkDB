CREATE PROCEDURE [dbo].[uspCPImportCase]
(
	  @StateCaseNumber varchar(50)
	, @LocalCaseNumber varchar(50)
	, @CaseWorkerNumber varchar(20)
	, @pkCPRefClientCaseProgramType decimal (18,0)
	, @fkCPClientCaseHead decimal = NULL
	, @pkCPClientCase decimal (18,0) output
)
AS

SET NOCOUNT ON

DECLARE   @pkApplicationUser decimal(18,0)
		, @LocalCaseNumberCurrent varchar(20)
		, @fkCPRefClientCaseProgramTypeCurrent decimal
		, @fkCPCaseWorkerCurrent decimal
		, @fkCPClientCaseHeadCurrent decimal
		, @HostName varchar(100)
		
SELECT @HostName = HOST_NAME()
SELECT @pkCPClientCase = 0
		
SELECT @pkApplicationUser = fkApplicationUser
FROM ApplicationUser AU
LEFT JOIN CpCaseWorkerAltId b ON AU.pkApplicationUser = b.fkapplicationuser
WHERE dbo.StripLeadingZeros(StateID) = dbo.StripLeadingZeros(@CaseWorkerNumber)
OR b.WorkerId = @CaseWorkerNumber

SELECT TOP 1 @pkCPClientCase = pkCPClientCase
	 , @LocalCaseNumberCurrent = LocalCaseNumber
	 , @fkCPRefClientCaseProgramTypeCurrent = fkCPRefClientCaseProgramType
	 , @fkCPCaseWorkerCurrent = fkCPCaseWorker
	 , @fkCPClientCaseHeadCurrent = fkCPClientCaseHead
FROM CPClientCase (NOLOCK)
WHERE StateCaseNumber = @StateCaseNumber
--AND LocalCaseNumber = @LocalCaseNumber
AND fkCPRefClientCaseProgramType = @pkCPRefClientCaseProgramType
order by pkCPClientCase

IF @pkCPClientCase <> 0 
BEGIN
	IF ISNULL(@LocalCaseNumberCurrent,'') <> @LocalCaseNumber
	OR ISNULL(@fkCPRefClientCaseProgramTypeCurrent,0) <> @pkCPRefClientCaseProgramType
	OR ISNULL(@fkCPCaseWorkerCurrent,0) <> ISNULL(@pkApplicationUser,0)
	OR ISNULL(@fkCPClientCaseHeadCurrent,0) <> ISNULL(@fkCPClientCaseHead,0)
	BEGIN
		EXEC dbo.uspCPClientCaseUpdate @pkCPClientCase = @pkCPClientCase
									 , @StateCaseNumber = @StateCaseNumber
									 , @LocalCaseNumber = @LocalCaseNumber
									 , @fkCPRefClientCaseProgramType = @pkCPRefClientCaseProgramType
									 , @fkApplicationUser = @pkApplicationUser
									 , @fkCPClientCaseHead  =  @fkCPClientCaseHead
									 , @LUPUser = @HostName
									 , @LUPMac = @HostName
									 , @LUPIP = @HostName
									 , @LUPMachine = @HostName
									 , @DistrictId = @CaseWorkerNumber
	END
END
ELSE
BEGIN
	EXEC dbo.uspCPClientCaseInsert @StateCaseNumber = @StateCaseNumber
								 , @LocalCaseNumber = @LocalCaseNumber
								 , @fkCPRefClientCaseProgramType = @pkCPRefClientCaseProgramType
								 , @fkApplicationUser = @pkApplicationUser
								 , @fkCPClientCaseHead  =  @fkCPClientCaseHead
								 , @LUPUser = @HostName
								 , @LUPMac = @HostName
								 , @LUPIP = @HostName
								 , @LUPMachine = @HostName
								 , @DistrictId = @CaseWorkerNumber
								 , @pkCPClientCase = @pkCPClientCase output
END