----------------------------------------------------------------------------
-- Insert a single record into CPClientMilitaryRecord
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPClientMilitaryRecordInsert]
(	  @fkCPClient decimal(18, 0) = NULL
	, @fkCPRefMilitaryBranch decimal(18, 0) = NULL
	, @StartDate datetime = NULL
	, @EndDate datetime = NULL
	, @DishonorablyDischarged bit = NULL
	, @LockedUser varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPClientMilitaryRecord decimal(18, 0) = NULL OUTPUT 
	, @EventStart varchar(50) = null
	, @EventEnd varchar(50) = null
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPClientMilitaryRecord
(	  fkCPClient
	, fkCPRefMilitaryBranch
	, StartDate
	, EndDate
	, DishonorablyDischarged
	, LockedUser
	, LockedDate
	, EventStart
	, EventEnd
)
VALUES 
(	  @fkCPClient
	, @fkCPRefMilitaryBranch
	, @StartDate
	, @EndDate
	, @DishonorablyDischarged
	, @LockedUser
	, @LockedDate
	, @EventStart
	, @EventEnd

)

SET @pkCPClientMilitaryRecord = SCOPE_IDENTITY()
