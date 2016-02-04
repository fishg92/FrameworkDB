----------------------------------------------------------------------------
-- Update a single record in JoinEventTypeFormName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinEventTypeFormNameUpdate]
(	  @pkJoinEventTypeFormName decimal(18, 0)
	, @fkEventType decimal(18, 0) = NULL
	, @fkFormName decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinEventTypeFormName
SET	fkEventType = ISNULL(@fkEventType, fkEventType),
	fkFormName = ISNULL(@fkFormName, fkFormName)
WHERE 	pkJoinEventTypeFormName = @pkJoinEventTypeFormName
