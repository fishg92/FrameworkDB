----------------------------------------------------------------------------
-- Update a single record in AgencyConfig
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAgencyConfigUpdate]
(	  @pkAgencyConfig decimal(18, 0)
	, @AgencyName varchar(100) = NULL
	, @fkSupervisor decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	AgencyConfig
SET	AgencyName = ISNULL(@AgencyName, AgencyName),
	fkSupervisor = ISNULL(@fkSupervisor, fkSupervisor)
WHERE 	pkAgencyConfig = @pkAgencyConfig
