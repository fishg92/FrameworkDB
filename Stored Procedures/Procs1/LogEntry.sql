CREATE PROCEDURE [api].[LogEntry]
	 @Message text
AS

EXEC [dbo].[usp_LogEntry] 
	 @Message = @Message
	,@Source = 'WebAPI'
	,@ApplicationID = -2
	,@AssociateWith = 'WebAPI'
	,@CreateUser = 'WebAPI'
	,@EntryType = 'CriticalError'