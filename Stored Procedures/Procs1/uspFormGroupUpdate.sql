
----------------------------------------------------------------------------
-- Update a single record in FormGroup
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormGroupUpdate]
(	  @pkFormGroup decimal(10, 0)
	, @fkFormGroupName decimal(10, 0) = NULL
	, @Status tinyint = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormGroup
SET	fkFormGroupName = ISNULL(@fkFormGroupName, fkFormGroupName),
	Status = ISNULL(COALESCE(@Status, 0), Status)
WHERE 	pkFormGroup = @pkFormGroup
