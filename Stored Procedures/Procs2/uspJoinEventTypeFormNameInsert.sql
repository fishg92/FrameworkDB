----------------------------------------------------------------------------
-- Insert a single record into JoinEventTypeFormName
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinEventTypeFormNameInsert]
(	  @fkEventType decimal(18, 0) = NULL
	, @fkFormName decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinEventTypeFormName decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinEventTypeFormName
(	  fkEventType
	, fkFormName
)
VALUES 
(	  @fkEventType
	, @fkFormName

)

SET @pkJoinEventTypeFormName = SCOPE_IDENTITY()
