----------------------------------------------------------------------------
-- Insert a single record into CPRefImportLogEventType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPRefImportLogEventTypeInsert]
(	  @EventType varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPRefImportLogEventType decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPRefImportLogEventType
(	  EventType
)
VALUES 
(	  @EventType

)

SET @pkCPRefImportLogEventType = SCOPE_IDENTITY()
