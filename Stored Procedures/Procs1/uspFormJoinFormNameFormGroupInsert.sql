-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormJoinFormNameFormGroup
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormJoinFormNameFormGroupInsert]
(	  @fkFormGroup decimal(10, 0)
	, @fkFormName decimal(10, 0)
	, @fkFormJoinFormNameFormGroupParent decimal(10, 0) = NULL
	, @fkFormGroupFormCaption decimal(10, 0) = NULL
	, @Copies int = NULL
	, @FormOrder int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormJoinFormNameFormGroup decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormJoinFormNameFormGroup
(	  fkFormGroup
	, fkFormName
	, fkFormJoinFormNameFormGroupParent
	, fkFormGroupFormCaption
	, Copies
	, FormOrder
)
VALUES 
(	  @fkFormGroup
	, @fkFormName
	, COALESCE(@fkFormJoinFormNameFormGroupParent, 0)
	, COALESCE(@fkFormGroupFormCaption, 0)
	, COALESCE(@Copies, 1)
	, COALESCE(@FormOrder, 0)

)

SET @pkFormJoinFormNameFormGroup = SCOPE_IDENTITY()
