-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from FormGroup
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormGroupDelete]
(	@pkFormGroup int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	FormGroup
WHERE 	pkFormGroup = @pkFormGroup
