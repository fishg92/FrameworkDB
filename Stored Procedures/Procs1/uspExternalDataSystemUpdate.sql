----------------------------------------------------------------------------
-- Update a single record in ExternalDataSystem
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspExternalDataSystemUpdate]
(	  @pkExternalDataSystem decimal(18, 0)
	, @Name varchar(255) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	ExternalDataSystem
SET	Name = ISNULL(@Name, Name)
WHERE 	pkExternalDataSystem = @pkExternalDataSystem
