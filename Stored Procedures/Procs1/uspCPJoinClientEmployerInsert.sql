----------------------------------------------------------------------------
-- Insert a single record into CPJoinClientEmployer
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPJoinClientEmployerInsert]
(	  @fkCPClient decimal(18, 0) = NULL
	, @fkCPEmployer decimal(18, 0) = NULL
	, @StartDate datetime = NULL
	, @EndDate datetime = NULL
	, @LockedUser varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPJoinClientEmployer decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPJoinClientEmployer
(	  fkCPClient
	, fkCPEmployer
	, StartDate
	, EndDate
	, LockedUser
	, LockedDate
)
VALUES 
(	  @fkCPClient
	, @fkCPEmployer
	, @StartDate
	, @EndDate
	, @LockedUser
	, @LockedDate

)

SET @pkCPJoinClientEmployer = SCOPE_IDENTITY()
