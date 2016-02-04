----------------------------------------------------------------------------
-- Select a single record from Department
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspDepartmentSelect]
(	@pkDepartment decimal(18, 0) = NULL,
	@DepartmentName varchar(100) = NULL,
	@fkAgencyLOB decimal(18, 0) = NULL,
	@fkSupervisor decimal(18, 0) = NULL
)
AS

SELECT	pkDepartment,
	DepartmentName,
	fkAgencyLOB,
	fkSupervisor
FROM	Department
WHERE 	(@pkDepartment IS NULL OR pkDepartment = @pkDepartment)
 AND 	(@DepartmentName IS NULL OR DepartmentName LIKE @DepartmentName + '%')
 AND 	(@fkAgencyLOB IS NULL OR fkAgencyLOB = @fkAgencyLOB)
 AND 	(@fkSupervisor IS NULL OR fkSupervisor = @fkSupervisor)

