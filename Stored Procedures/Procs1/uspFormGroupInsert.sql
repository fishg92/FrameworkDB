-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormGroup
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormGroupInsert]
(	  @fkFormGroupName decimal(10, 0)
	, @Status tinyint = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormGroup decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormGroup
(	  fkFormGroupName
	, Status
)
VALUES 
(	  @fkFormGroupName
	, COALESCE(@Status, 0)

)

SET @pkFormGroup = SCOPE_IDENTITY()
