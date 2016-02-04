-- Stored Procedure

CREATE proc [dbo].[uspFormEditFormGroup]
(	  @FormGroupName varchar(255)
	, @Status int
	, @pkFormGroup decimal(10, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormGroupName decimal(10, 0) output
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	Set @pkFormGroupName = IsNull((Select pkFormGroupName From FormGroupName where [Name] = @FormGroupName),0)

	If @pkFormGroupName = 0 
	begin

		Insert Into FormGroupname
		(	[Name])
		Values
		(	@FormGroupName)

		Set @pkFormGroupName = Scope_Identity()
	end

	Update 	FormGroup
	Set	fkFormGroupName = @pkFormGroupName,
		Status = @Status
	Where	pkFormGroup = @pkFormGroup
