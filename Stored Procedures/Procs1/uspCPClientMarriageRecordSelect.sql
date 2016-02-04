----------------------------------------------------------------------------
-- Select a single record from CPClientMarriageRecord
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPClientMarriageRecordSelect]
(	@pkCPClientMarriageRecord decimal(18, 0) = NULL,
	@fkCPClient decimal(18, 0) = NULL,
	@StartDate datetime = NULL,
	@EndDate datetime = NULL,
	@fkCPRefMarraigeEndType decimal(18, 0) = NULL,
	@LockedUser varchar(50) = NULL,
	@LockedDate datetime = NULL,
	@Spouse varchar(50) = NULL,
	@EventDate varchar(50) = null
)
AS

SELECT	pkCPClientMarriageRecord,
	fkCPClient,
	StartDate,
	EndDate,
	fkCPRefMarraigeEndType,
	LockedUser,
	LockedDate,
	Spouse,
	EventDateFreeForm
FROM	CPClientMarriageRecord
WHERE 	(@pkCPClientMarriageRecord IS NULL OR pkCPClientMarriageRecord = @pkCPClientMarriageRecord)
 AND 	(@fkCPClient IS NULL OR fkCPClient = @fkCPClient)
 AND 	(@StartDate IS NULL OR StartDate = @StartDate)
 AND 	(@EndDate IS NULL OR EndDate = @EndDate)
 AND 	(@fkCPRefMarraigeEndType IS NULL OR fkCPRefMarraigeEndType = @fkCPRefMarraigeEndType)
 AND 	(@LockedUser IS NULL OR LockedUser LIKE @LockedUser + '%')
 AND 	(@LockedDate IS NULL OR LockedDate = @LockedDate)
 AND 	(@Spouse IS NULL OR Spouse LIKE @Spouse + '%')
 AND 	(@EventDate IS NULL OR EventDateFreeForm LIKE @EventDate + '%')
