----------------------------------------------------------------------------
-- Insert a single record into Department
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspDepartmentInsert]
(	  @DepartmentName varchar(100)
	, @fkAgencyLOB decimal(18, 0)
	, @fkSupervisor decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkDepartment decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT Department
(	  DepartmentName
	, fkAgencyLOB
	, fkSupervisor
)
VALUES 
(	  @DepartmentName
	, @fkAgencyLOB
	, COALESCE(@fkSupervisor, (-1))
)

SET @pkDepartment = SCOPE_IDENTITY()
