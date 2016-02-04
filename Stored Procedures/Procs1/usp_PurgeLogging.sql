
CREATE PROC [dbo].[usp_PurgeLogging]
(	@DaysToPurge integer = NULL
)
AS
set @DaysToPurge = isnull(@DaysToPurge,1) 
declare @StartDate datetime
declare @EndDate datetime
declare @CutoffDate datetime
set @CutoffDate = DateAdd(Day, -4, GetDate())

if @DaysToPurge > 0 BEGIN
	select @StartDate = min(datetime) from Logging (NOLOCK)
		WHERE ApplicationID = -5
		AND [DateTime] < @CutoffDate
	if @StartDate is not null BEGIN
		set @EndDate = DateAdd(Day,@DaysToPurge,@StartDate)
		if @EndDate < @CutoffDate BEGIN
			Delete Logging
				WHERE ApplicationID = -5
				AND [DateTime] <= @EndDate		
		END
	END
END
