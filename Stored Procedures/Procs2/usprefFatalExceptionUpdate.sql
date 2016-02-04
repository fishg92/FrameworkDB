----------------------------------------------------------------------------
-- Update a single record in refFatalException
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefFatalExceptionUpdate]
(	  @pkrefFatalException decimal(18, 0)
	, @Message varchar(1000) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	refFatalException
SET	Message = ISNULL(@Message, Message)
WHERE 	pkrefFatalException = @pkrefFatalException
