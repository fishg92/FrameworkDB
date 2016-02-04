-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from CPJoinClientEmployer
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPDeleteEmployerFromClient]
(	
	@pkCPClient decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	CPJoinClientEmployer
WHERE 	fkCPClient = @pkCPClient
