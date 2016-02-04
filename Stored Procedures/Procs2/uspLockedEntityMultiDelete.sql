-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from LockedEntity
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspLockedEntityMultiDelete]
(	  @fkCPClient decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

SELECT pklockedEntity 
INTO #ToDelete
FROM LockedEntity (nolock)
WHERE 	fkCPClient = @fkCPClient

DELETE	LockedEntity
WHERE 	fkCPClient = @fkCPClient

SELECT * from #ToDelete
