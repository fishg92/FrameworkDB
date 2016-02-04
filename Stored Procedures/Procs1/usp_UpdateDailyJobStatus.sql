CREATE PROC [dbo].[usp_UpdateDailyJobStatus]
(
	@pkRefDailyJob int
	, @Status varchar(10)
	, @DateTime datetime
)
AS
BEGIN
	IF @Status = 'Started'
	BEGIN
		UPDATE dbo.RefDailyJob
		SET DateLastStarted = @DateTime
		WHERE pkRefDailyJob = @pkRefDailyJob
	END
	ELSE
	BEGIN
		UPDATE dbo.RefDailyJob
		SET DateLastCompleted = @DateTime
		WHERE pkRefDailyJob = @pkRefDailyJob
	END
END