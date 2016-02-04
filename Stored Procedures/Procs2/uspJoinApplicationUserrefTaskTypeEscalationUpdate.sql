----------------------------------------------------------------------------
-- Update a single record in JoinApplicationUserrefTaskTypeEscalation
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinApplicationUserrefTaskTypeEscalationUpdate]
(	  @pkJoinApplicationUserrefTaskTypeEscalation decimal(18, 0)
	, @fkrefTaskTypeEscalation decimal(18, 0) = NULL
	, @fkApplicationUser decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinApplicationUserrefTaskTypeEscalation
SET	fkrefTaskTypeEscalation = ISNULL(@fkrefTaskTypeEscalation, fkrefTaskTypeEscalation),
	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser)
WHERE 	pkJoinApplicationUserrefTaskTypeEscalation = @pkJoinApplicationUserrefTaskTypeEscalation
