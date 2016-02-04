----------------------------------------------------------------------------
-- Update a single record in RefDailyJob
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspRefDailyJobUpdate]
(	  @pkRefDailyJob decimal(18, 0)
	, @JobName varchar(50) = NULL
	, @Description varchar(255) = NULL
	, @Query varchar(MAX) = NULL
	, @StartTime datetime = NULL
	, @EndTime datetime = NULL
	, @Active bit = NULL
	, @DateLastStarted datetime = NULL
	, @DateLastCompleted datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	RefDailyJob
SET	JobName = ISNULL(@JobName, JobName),
	Description = ISNULL(@Description, Description),
	Query = ISNULL(@Query, Query),
	StartTime = ISNULL(@StartTime, StartTime),
	EndTime = ISNULL(@EndTime, EndTime),
	Active = ISNULL(@Active, Active),
	DateLastStarted = ISNULL(@DateLastStarted, DateLastStarted),
	DateLastCompleted = ISNULL(@DateLastCompleted, DateLastCompleted)
WHERE 	pkRefDailyJob = @pkRefDailyJob
