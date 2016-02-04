----------------------------------------------------------------------------
-- Select a single record from AgencyLOB
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAgencyLOBSelect]
(	@pkAgencyLOB decimal(18, 0) = NULL,
	@AgencyLOBName varchar(100) = NULL,
	@fkAgency decimal(18, 0) = NULL,
	@fkSupervisor decimal(18, 0) = NULL
)
AS

SELECT	pkAgencyLOB,
	AgencyLOBName,
	fkAgency,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate,
	fkSupervisor
FROM	AgencyLOB
WHERE 	(@pkAgencyLOB IS NULL OR pkAgencyLOB = @pkAgencyLOB)
 AND 	(@AgencyLOBName IS NULL OR AgencyLOBName LIKE @AgencyLOBName + '%')
 AND 	(@fkAgency IS NULL OR fkAgency = @fkAgency)
 AND 	(@fkSupervisor IS NULL OR fkSupervisor = @fkSupervisor)

