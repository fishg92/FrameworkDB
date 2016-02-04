----------------------------------------------------------------------------
-- Insert a single record into LockedEntity
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspLockedEntityInsert]
(	  @fkCPClient decimal(18, 0) = NULL
	, @fkProgramType decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkLockedEntity decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT LockedEntity
(	  fkCPClient
	, fkProgramType
)
VALUES 
(	  @fkCPClient
	, @fkProgramType

)

SET @pkLockedEntity = SCOPE_IDENTITY()
