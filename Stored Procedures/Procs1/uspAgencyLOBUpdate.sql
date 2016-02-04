----------------------------------------------------------------------------
-- Update a single record in AgencyLOB
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAgencyLOBUpdate]
(	  @pkAgencyLOB decimal(18, 0)
	, @AgencyLOBName varchar(100) = NULL
	, @fkAgency decimal(18, 0) = NULL
	, @fkSupervisor decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	AgencyLOB
SET	AgencyLOBName = ISNULL(@AgencyLOBName, AgencyLOBName),
	fkAgency = ISNULL(@fkAgency, fkAgency),
	fkSupervisor = ISNULL(@fkSupervisor, fkSupervisor)
WHERE 	pkAgencyLOB = @pkAgencyLOB
