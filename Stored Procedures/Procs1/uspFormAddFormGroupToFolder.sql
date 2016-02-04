-- Stored Procedure

CREATE proc [dbo].[uspFormAddFormGroupToFolder]
(	 @pkFormGroup decimal(18, 0)
	,@pkFormFolder decimal(18, 0)
	,@CurrentpkFormFolder decimal(18, 0)
	,@Copy tinyint = 0
    , @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	,@pkFormJoinFormFolderFormGroup decimal(18, 0) output
)

as

exec dbo.SetAuditDataContext @LupUser, @LupMachine


	If @Copy = 0 	
	begin

		Delete From 	FormJoinFormFOlderFormGroup
		Where		fkFormGroup = @pkFormGroup
		and		fkFormFolder = @CurrentpkFormFolder

	end

	Insert Into FormJoinFormFolderFormGroup
	(	fkFormGroup,
		fkFormFolder)
	Values
	(	@pkFormGroup,
		@pkFormFolder)

	SET @pkFormJoinFormFolderFormGroup = SCOPE_IDENTITY()
