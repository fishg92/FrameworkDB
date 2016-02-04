-- Stored Procedure

CREATE proc [dbo].[uspFormAddFormGroup]
(	 @FormGroupName varchar(255)
	,@Status int
, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	,@pkFormGroup decimal(18, 0) output
	,@pkFormGroupName decimal(18, 0) output
)
as

exec dbo.SetAuditDataContext @LupUser, @LupMachine


	Set @pkFormGroupName = IsNull((Select pkFormGroupName From FormGroupName where Name = @FormGroupName),0)

	If @pkFormGroupName = 0 
	begin

		Insert Into FormGroupname
		(	Name)
		Values
		(	@FormGroupName)

		Set @pkFormGroupName = Scope_Identity()
	end

	Insert Into FormGroup
	(	fkFormGroupName,
		Status)
	Values
	(	@pkFormGroupname,
		@Status)

	Set @pkFormGroup = Scope_Identity()
