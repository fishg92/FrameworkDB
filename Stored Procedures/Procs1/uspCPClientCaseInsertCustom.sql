-- Stored Procedure

-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into CPClientCase
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPClientCaseInsertCustom]
(	  @StateCaseNumber varchar(20) = NULL
	, @LocalCaseNumber varchar(20) = NULL
	, @fkCPRefClientCaseProgramType varchar(50) = NULL
	, @fkCPCaseWorker decimal(18, 0) = NULL
	, @LockedUser varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @fkCPClientCaseHead decimal (18,0) = NULL
	, @fkApplicationUser decimal (18,0) = NULL
	, @pkCPClientCase decimal(18, 0) = NULL OUTPUT
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

SET NOCOUNT on
declare @pkToCheckFor decimal
set @pkToCheckFor = 0



SELECT @pkToCheckFor = pkCPClientCase FROM [CPClientCase] WITH (NOLOCK)
WHERE UPPER(LTRIM(RTRIM(ISNULL([StateCaseNumber], '')))) = UPPER(LTRIM(RTRIM(@StateCaseNumber)))
AND UPPER(LTRIM(RTRIM(ISNULL([LocalCaseNumber], '')))) = UPPER(LTRIM(RTRIM(@LocalCaseNumber)))

IF ISNULL(@pkToCheckFor, 0) = 0
	begin

		exec dbo.uspCPClientCaseInsert
			 @StateCaseNumber = @StateCaseNumber
			, @LocalCaseNumber = @LocalCaseNumber 
			, @fkCPRefClientCaseProgramType = @fkCPRefClientCaseProgramType
			, @fkCPCaseWorker = @fkCPCaseWorker 
			, @LockedUser = @LockedUser
			, @LockedDate = @LockedDate
			, @fkCPClientCaseHead = @fkCPClientCaseHead
			, @fkApplicationUser = @fkApplicationUser
			, @LUPUser = @LUPUser
			, @LUPMac = @LUPMac
			, @LUPIP = @LUPIP
			, @LUPMachine = @LUPMachine
			, @pkCPClientCase = @pkCPClientCase OUTPUT 
	end
else
	begin
		SET @pkCPClientCase = @pkToCheckFor
	end
