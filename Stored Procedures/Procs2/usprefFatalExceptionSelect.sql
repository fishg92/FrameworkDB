----------------------------------------------------------------------------
-- Select a single record from refFatalException
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefFatalExceptionSelect]
(	@pkrefFatalException decimal(18, 0) = NULL,
	@Message varchar(1000) = NULL
)
AS

SELECT	pkrefFatalException,
	Message
FROM	refFatalException
WHERE 	(@pkrefFatalException IS NULL OR pkrefFatalException = @pkrefFatalException)
 AND 	(@Message IS NULL OR Message LIKE @Message + '%')
