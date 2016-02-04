-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormEditFormGroupForm]
(	  @pkFormJoinFormNameFormGroup decimal(18,0)
	, @FormOrder int
	, @Copies int
	, @fkParent decimal(18,0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	UPDATE FormJoinFormNameFormGroup
	SET   FormOrder = @FormOrder
		, Copies = @Copies
		, fkFormJoinFormNameFormGroupParent = @fkParent
	WHERE pkFormJoinFormNameFormGroup = @pkFormJoinFormNameFormGroup
