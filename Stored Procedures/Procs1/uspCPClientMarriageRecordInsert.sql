----------------------------------------------------------------------------
-- Insert a single record into CPClientMarriageRecord
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPClientMarriageRecordInsert]
(	  @fkCPClient decimal(18, 0) = NULL
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
	, @pkCPClientMarriageRecord decimal(18, 0) = NULL OUTPUT 
	, @EventDate varchar(50) = null
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPClientMarriageRecord
(	  fkCPClient
	, StartDate
	, EndDate
	, fkCPRefMarraigeEndType
	, LockedUser
	, LockedDate
	, Spouse
	, EventDateFreeForm
)
VALUES 
(	  @fkCPClient
	, @StartDate
	, @EndDate
	, @fkCPRefMarraigeEndType
	, @LockedUser
	, @LockedDate
	, @Spouse
	, @EventDate
)

SET @pkCPClientMarriageRecord = SCOPE_IDENTITY()
