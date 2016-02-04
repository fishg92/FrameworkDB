-- Stored Procedure

-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in CPClientCase
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPClientCaseUpdateCustom]
(	  @pkCPClientCase decimal(18, 0)
	, @StateCaseNumber varchar(20) = NULL
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
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

exec [uspCPClientCaseUpdate]
	  @pkCPClientCase
	, @StateCaseNumber
	, @LocalCaseNumber 
	, @fkCPRefClientCaseProgramType 
	, @fkCPCaseWorker 
	, @LockedUser 
	, @LockedDate 
	, @fkCPClientCaseHead 
	, @fkApplicationUser
	, @LUPUser
	, @LUPMac 
	, @LUPIP 
	, @LUPMachine
