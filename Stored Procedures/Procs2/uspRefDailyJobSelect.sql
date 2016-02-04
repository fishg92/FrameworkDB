----------------------------------------------------------------------------
-- Select a single record from RefDailyJob
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspRefDailyJobSelect]
(	@pkRefDailyJob decimal(18, 0) = NULL,
	@JobName varchar(50) = NULL,
	@Description varchar(255) = NULL,
	@Query varchar(MAX) = NULL,
	@StartTime datetime = NULL,
	@EndTime datetime = NULL,
	@Active bit = NULL,
	@DateLastStarted datetime = NULL,
	@DateLastCompleted datetime = NULL
)
AS

SELECT	pkRefDailyJob,
	JobName,
	Description,
	Query,
	StartTime,
	EndTime,
	Active,
	DateLastStarted,
	DateLastCompleted
FROM	RefDailyJob
WHERE 	(@pkRefDailyJob IS NULL OR pkRefDailyJob = @pkRefDailyJob)
 AND 	(@JobName IS NULL OR JobName LIKE @JobName + '%')
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')
 AND 	(@Query IS NULL OR Query LIKE @Query + '%')
 AND 	(@StartTime IS NULL OR StartTime = @StartTime)
 AND 	(@EndTime IS NULL OR EndTime = @EndTime)
 AND 	(@Active IS NULL OR Active = @Active)
 AND 	(@DateLastStarted IS NULL OR DateLastStarted = @DateLastStarted)
 AND 	(@DateLastCompleted IS NULL OR DateLastCompleted = @DateLastCompleted)
