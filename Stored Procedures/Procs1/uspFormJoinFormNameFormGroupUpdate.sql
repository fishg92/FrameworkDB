-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormJoinFormNameFormGroup
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormJoinFormNameFormGroupUpdate]
(	  @pkFormJoinFormNameFormGroup decimal(10, 0)
	, @fkFormGroup decimal(10, 0) = NULL
	, @fkFormName decimal(10, 0) = NULL
	, @fkFormJoinFormNameFormGroupParent decimal(10, 0) = NULL
	, @fkFormGroupFormCaption decimal(10, 0) = NULL
	, @Copies int = NULL
	, @FormOrder int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)

)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormJoinFormNameFormGroup
SET	fkFormGroup = ISNULL(@fkFormGroup, fkFormGroup),
	fkFormName = ISNULL(@fkFormName, fkFormName),
	fkFormJoinFormNameFormGroupParent = ISNULL(COALESCE(@fkFormJoinFormNameFormGroupParent, 0), fkFormJoinFormNameFormGroupParent),
	fkFormGroupFormCaption = ISNULL(COALESCE(@fkFormGroupFormCaption, 0), fkFormGroupFormCaption),
	Copies = ISNULL(COALESCE(@Copies, 1), Copies),
	FormOrder = ISNULL(COALESCE(@FormOrder, 0), FormOrder)
WHERE 	pkFormJoinFormNameFormGroup = @pkFormJoinFormNameFormGroup
