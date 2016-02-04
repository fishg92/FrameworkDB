----------------------------------------------------------------------------
-- Insert a single record into refFatalException
----------------------------------------------------------------------------
CREATE Proc [dbo].[usprefFatalExceptionInsert]
(	  @Message varchar(1000)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkrefFatalException decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT refFatalException
(	  Message
)
VALUES 
(	  @Message

)

SET @pkrefFatalException = SCOPE_IDENTITY()
