----------------------------------------------------------------------------
-- Insert a single record into RefDailyJob
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspRefDailyJobInsert]
(	  @JobName varchar(50)
	, @Description varchar(255)
	, @Query varchar(MAX)
	, @StartTime datetime
	, @EndTime datetime = NULL
	, @Active bit
	, @DateLastStarted datetime = NULL
	, @DateLastCompleted datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkRefDailyJob decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT RefDailyJob
(	  JobName
	, Description
	, Query
	, StartTime
	, EndTime
	, Active
	, DateLastStarted
	, DateLastCompleted
)
VALUES 
(	  @JobName
	, @Description
	, @Query
	, @StartTime
	, @EndTime
	, @Active
	, @DateLastStarted
	, @DateLastCompleted

)

SET @pkRefDailyJob = SCOPE_IDENTITY()
