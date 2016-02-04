----------------------------------------------------------------------------
-- Update a single record in JoinApplicationUserProgramType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinApplicationUserProgramTypeUpdate]
(	  @pkJoinApplicationUserProgramType decimal(18, 0)
	, @fkApplicationUser decimal(18, 0) = NULL
	, @fkProgramType decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinApplicationUserProgramType
SET	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser),
	fkProgramType = ISNULL(@fkProgramType, fkProgramType)
WHERE 	pkJoinApplicationUserProgramType = @pkJoinApplicationUserProgramType
