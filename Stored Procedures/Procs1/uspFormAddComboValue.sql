-- Stored Procedure

CREATE proc [dbo].[uspFormAddComboValue]
(	 @fkFormComboName decimal(18, 0)
	,@ComboValue varchar(255)
, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	,@pkFormComboValue decimal(18, 0) output
	,@pkFormJoinFormComboNameFormComboValue decimal(18, 0) output
)

as

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	/* Get a reference to our combo value just normalize it if necessary */
	--JE 05-28-08 Added the Collate to treat the search as case-sensitive
	Set @pkFormComboValue = (Select pkFormComboValue From FormComboValue where ComboValue = @ComboValue COLLATE latin1_general_cs_as)

	If IsNull(@pkFormComboValue,0) = 0 
	begin

		Insert Into FormComboValue
		(	ComboValue)
		Values
		(	@ComboValue)

		Set @pkFormComboValue = Scope_Identity()
	end

	/* ALTER a relationship between the combo value and the combo name */

	Insert Into FormJoinFormComboNameFormComboValue
	(	fkFormComboName,
		fkFormComboValue)
	Values
	(	@fkFormComboName,
		@pkFormComboValue)

	SET @pkFormJoinFormComboNameFormComboValue = SCOPE_IDENTITY()
