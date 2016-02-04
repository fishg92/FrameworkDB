-- Stored Procedure

CREATE proc [dbo].[uspFormAddFormToFormGroup]
(	@pkFormGroup decimal(18, 0),
	@pkFormName decimal(18, 0),
	@fkFormJoinFormNameFormGroupParent decimal(18, 0) = 0,
	@FormCaption varchar(255) = '',
	@Copies int = 1
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	,@pkFormJoinFormNameFormGroup decimal(18, 0) output
)

as

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	Insert Into FormJoinFormNameFormGroup
	(	fkFormGroup,
		fkFormName,
		fkFormJoinFormNameFormGroupParent,
		fkFormGroupFormCaption,
		Copies)
	Values
	(	@pkFormGroup,
		@pkFormName,
		@fkFormJoinFormNameFormGroupParent,
		0,
		@Copies)

	Set @pkFormJoinFormNameFormGroup = Scope_Identity()
