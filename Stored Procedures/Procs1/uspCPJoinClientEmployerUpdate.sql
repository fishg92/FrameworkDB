----------------------------------------------------------------------------
-- Update a single record in CPJoinClientEmployer
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPJoinClientEmployerUpdate]
(	  @pkCPJoinClientEmployer decimal(18, 0)
	, @fkCPClient decimal(18, 0) = NULL
	, @fkCPEmployer decimal(18, 0) = NULL
	, @StartDate datetime = NULL
	, @EndDate datetime = NULL
	, @LockedUser varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPJoinClientEmployer
SET	fkCPClient = ISNULL(@fkCPClient, fkCPClient),
	fkCPEmployer = ISNULL(@fkCPEmployer, fkCPEmployer),
	StartDate = ISNULL(@StartDate, StartDate),
	EndDate = ISNULL(@EndDate, EndDate),
	LockedUser = ISNULL(@LockedUser, LockedUser),
	LockedDate = ISNULL(@LockedDate, LockedDate)
WHERE 	pkCPJoinClientEmployer = @pkCPJoinClientEmployer
