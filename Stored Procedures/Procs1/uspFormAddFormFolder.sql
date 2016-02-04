-- Stored Procedure

CREATE proc [dbo].[uspFormAddFormFolder]
(	@FolderName varchar(255),
	@Description varchar(500),
	@pkParentFormFolder decimal(18, 0)
, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	,@pkFormFolder decimal(18, 0) output
)
as

exec dbo.SetAuditDataContext @LupUser, @LupMachine


	Declare @pkFormFolderName decimal(18, 0)

	Set @pkFormFolderName = (Select pkFormFolderName from FormFolderName where FolderName = @FolderName)

	If IsNull(@pkFormFolderName,0) = 0 
	begin

		Insert Into FormFolderName
		(	FolderName,
			Description)
		Values
		(	@FolderName,
			@Description)

		Set @pkFormFolderName = Scope_Identity()
	end

	Insert into FormFolder
	(	fkFormFolder,
		fkFormFolderName)
	Values
	(	@pkParentFormFolder,
		@pkFormFolderName)

	Set @pkFormFolder = Scope_Identity()
