----------------------------------------------------------------------------
-- Update a single record in Department
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspDepartmentUpdate]
(	  @pkDepartment decimal(18, 0)
	, @DepartmentName varchar(100) = NULL
	, @fkAgencyLOB decimal(18, 0) = NULL
	, @fkSupervisor decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	Department
SET	DepartmentName = ISNULL(@DepartmentName, DepartmentName),
	fkAgencyLOB = ISNULL(@fkAgencyLOB, fkAgencyLOB),
	fkSupervisor = ISNULL(@fkSupervisor, fkSupervisor)
WHERE 	pkDepartment = @pkDepartment
