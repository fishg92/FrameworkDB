----------------------------------------------------------------------------
-- Insert a single record into refTaskTypeEscalation
----------------------------------------------------------------------------
CREATE Proc [dbo].[usprefTaskTypeEscalationInsert]
(	  @fkrefTaskType decimal(18, 0)
	, @Sequence int
	, @MinutesAfterDueDate int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkrefTaskTypeEscalation decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT refTaskTypeEscalation
(	  fkrefTaskType
	, Sequence
	, MinutesAfterDueDate
)
VALUES 
(	  @fkrefTaskType
	, @Sequence
	, @MinutesAfterDueDate

)

SET @pkrefTaskTypeEscalation = SCOPE_IDENTITY()
