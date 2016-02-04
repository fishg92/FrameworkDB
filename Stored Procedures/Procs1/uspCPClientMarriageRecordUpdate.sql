----------------------------------------------------------------------------
-- Update a single record in CPClientMarriageRecord
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPClientMarriageRecordUpdate]
(	  @pkCPClientMarriageRecord decimal(18, 0)
	, @fkCPClient decimal(18, 0) = NULL
	, @StartDate datetime = NULL
	, @EndDate datetime = NULL
	, @fkCPRefMarraigeEndType decimal(18, 0) = NULL
	, @LockedUser varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @Spouse varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @EventDate varchar(50) = null
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPClientMarriageRecord
SET	fkCPClient = ISNULL(@fkCPClient, fkCPClient),
	StartDate = ISNULL(@StartDate, StartDate),
	EndDate = ISNULL(@EndDate, EndDate),
	fkCPRefMarraigeEndType = ISNULL(@fkCPRefMarraigeEndType, fkCPRefMarraigeEndType),
	LockedUser = ISNULL(@LockedUser, LockedUser),
	LockedDate = ISNULL(@LockedDate, LockedDate),
	Spouse = ISNULL(@Spouse, Spouse),
	EventDateFreeForm = isnull(@EventDate, EventDateFreeForm)
WHERE 	pkCPClientMarriageRecord = @pkCPClientMarriageRecord
