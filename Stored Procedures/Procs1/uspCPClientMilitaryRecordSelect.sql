----------------------------------------------------------------------------
-- Select a single record from CPClientMilitaryRecord
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPClientMilitaryRecordSelect]
(	@pkCPClientMilitaryRecord decimal(18, 0) = NULL,
	@fkCPClient decimal(18, 0) = NULL,
	@fkCPRefMilitaryBranch decimal(18, 0) = NULL,
	@StartDate datetime = NULL,
	@EndDate datetime = NULL,
	@DishonorablyDischarged bit = NULL,
	@LockedUser varchar(50) = NULL,
	@LockedDate datetime = NULL,
	@EventStart varchar(50) = null,
	@EventEnd varchar(50) = null
)
AS

SELECT	pkCPClientMilitaryRecord,
	fkCPClient,
	fkCPRefMilitaryBranch,
	StartDate,
	EndDate,
	DishonorablyDischarged,
	LockedUser,
	LockedDate,
	EventStart,
	EventEnd
FROM	CPClientMilitaryRecord
WHERE 	(@pkCPClientMilitaryRecord IS NULL OR pkCPClientMilitaryRecord = @pkCPClientMilitaryRecord)
 AND 	(@fkCPClient IS NULL OR fkCPClient = @fkCPClient)
 AND 	(@fkCPRefMilitaryBranch IS NULL OR fkCPRefMilitaryBranch = @fkCPRefMilitaryBranch)
 AND 	(@StartDate IS NULL OR StartDate = @StartDate)
 AND 	(@EndDate IS NULL OR EndDate = @EndDate)
 AND 	(@DishonorablyDischarged IS NULL OR DishonorablyDischarged = @DishonorablyDischarged)
 AND 	(@LockedUser IS NULL OR LockedUser LIKE @LockedUser + '%')
 AND 	(@LockedDate IS NULL OR LockedDate = @LockedDate)
 AND 	(@EventStart IS NULL OR EventStart LIKE @EventStart + '%')
 AND 	(@EventEnd IS NULL OR EventEnd LIKE @EventEnd + '%')