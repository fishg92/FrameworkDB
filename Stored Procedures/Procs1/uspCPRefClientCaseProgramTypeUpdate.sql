----------------------------------------------------------------------------
-- Update a single record in CPRefClientCaseProgramType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPRefClientCaseProgramTypeUpdate]
(	  @pkCPRefClientCaseProgramType decimal(18, 0)
	, @Description varchar(100) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPRefClientCaseProgramType
SET	Description = ISNULL(@Description, Description)
WHERE 	pkCPRefClientCaseProgramType = @pkCPRefClientCaseProgramType
