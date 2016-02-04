----------------------------------------------------------------------------
-- Update a single record in CPRefImportLogEventType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPRefImportLogEventTypeUpdate]
(	  @pkCPRefImportLogEventType decimal(18, 0)
	, @EventType varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPRefImportLogEventType
SET	EventType = ISNULL(@EventType, EventType)
WHERE 	pkCPRefImportLogEventType = @pkCPRefImportLogEventType
