----------------------------------------------------------------------------
-- Select a single record from CPRefImportLogEventType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPRefImportLogEventTypeSelect]
(	@pkCPRefImportLogEventType decimal(18, 0) = NULL,
	@EventType varchar(50) = NULL
)
AS

SELECT	pkCPRefImportLogEventType,
	EventType
FROM	CPRefImportLogEventType
WHERE 	(@pkCPRefImportLogEventType IS NULL OR pkCPRefImportLogEventType = @pkCPRefImportLogEventType)
 AND 	(@EventType IS NULL OR EventType LIKE @EventType + '%')

