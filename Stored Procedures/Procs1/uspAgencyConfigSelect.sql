----------------------------------------------------------------------------
-- Select a single record from AgencyConfig
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAgencyConfigSelect]
(	@pkAgencyConfig decimal(18, 0) = NULL,
	@AgencyName varchar(100) = NULL,
	@fkSupervisor decimal(18, 0) = NULL
)
AS

SELECT	pkAgencyConfig,
	AgencyName,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate,
	fkSupervisor
FROM	AgencyConfig
WHERE 	(@pkAgencyConfig IS NULL OR pkAgencyConfig = @pkAgencyConfig)
 AND 	(@AgencyName IS NULL OR AgencyName LIKE @AgencyName + '%')
 AND 	(@fkSupervisor IS NULL OR fkSupervisor = @fkSupervisor)

