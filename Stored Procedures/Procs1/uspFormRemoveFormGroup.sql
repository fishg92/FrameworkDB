-- Stored Procedure

CREATE proc [dbo].[uspFormRemoveFormGroup]
(	  @pkFormGroup decimal(18,0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
as

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	UPDATE FormGroup SET Status = 4 WHERE pkFormGroup = @pkFormGroup
