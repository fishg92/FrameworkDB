----------------------------------------------------------------------------
-- Update a single record in CPClientMilitaryRecord
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPClientMilitaryRecordUpdate]
(	  @pkCPClientMilitaryRecord decimal(18, 0)
	, @fkCPClient decimal(18, 0) = NULL
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
	, @EventStart varchar(50) = null
	, @EventEnd varchar(50) = null
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPClientMilitaryRecord
SET	fkCPClient = ISNULL(@fkCPClient, fkCPClient),
	fkCPRefMilitaryBranch = ISNULL(@fkCPRefMilitaryBranch, fkCPRefMilitaryBranch),
	StartDate = ISNULL(@StartDate, StartDate),
	EndDate = ISNULL(@EndDate, EndDate),
	DishonorablyDischarged = ISNULL(@DishonorablyDischarged, DishonorablyDischarged),
	LockedUser = ISNULL(@LockedUser, LockedUser),
	LockedDate = ISNULL(@LockedDate, LockedDate),
	EventStart = ISNULL(@EventStart, EventStart),
	EventEnd = ISNULL(@EventEnd, EventEnd)
WHERE 	pkCPClientMilitaryRecord = @pkCPClientMilitaryRecord
