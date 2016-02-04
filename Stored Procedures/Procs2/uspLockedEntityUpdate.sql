-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in LockedEntity
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspLockedEntityUpdate]
(	  @pkLockedEntity decimal(18, 0)
	, @fkCPClient decimal(18, 0) = NULL
	, @fkProgramType decimal(18, 0) = NULL
	, @LUPUser varchar(50)	
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	LockedEntity
SET	fkCPClient = ISNULL(@fkCPClient, fkCPClient),
	fkProgramType = ISNULL(@fkProgramType, fkProgramType)
WHERE 	pkLockedEntity = @pkLockedEntity
