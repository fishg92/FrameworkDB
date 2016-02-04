


CREATE PROC [dbo].[usp_GetRefDailyJob]
AS
BEGIN

select  
	pkRefDailyJob
	, JobName
	, [Description]
	, Query
	, StartTime
	, EndTime
	, DateLastStarted
	, DateLastCompleted
from refDailyJob with (NOLOCK)
where 1=1
and
		(
			CONVERT(VARCHAR(8),GETDATE(),105) <> CONVERT(VARCHAR(8),isnull(DateLastStarted, '1/1/1900'),105)
			and
			DATEDIFF(dd, 0, GETDATE()) >= DATEDIFF(dd, 0, StartTime)
			and
			DATEDIFF(dd, 0, GETDATE()) <= DATEDIFF(dd, 0, EndTime)
			and
			DateDiff(hour, CONVERT(VARCHAR(8),StartTime,108), CONVERT(VARCHAR(8),GETDATE(),108)) = 0 
			and 
			DateDiff(minute, CONVERT(VARCHAR(8),StartTime,108), CONVERT(VARCHAR(8),GETDATE(),108)) = 0
			and
			Active = 1
		)
END
