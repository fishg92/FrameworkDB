-- Stored Procedure

CREATE proc [dbo].[uspFormAddQuickListFolder]
(	 @QuickListFolderName varchar(255)
	,@Description varchar(500)
	,@fkParentQuickListFolder decimal(18, 0)
	,@fkFormUser decimal(18, 0)
, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	,@pkQuickListFolder decimal(18, 0) output
	,@pkFormQuickListFolderName decimal(18, 0) output
)
as

exec dbo.SetAuditDataContext @LupUser, @LupMachine


	Set @pkFormQuickListFolderName = IsNull((Select pkFormQuickListFolderName From FormQuickListFolderName where QuickListFolderName = @QuickListFolderName), 0)

	If @pkFormQuickListFolderName = 0
	begin
		Insert Into FormQuickListFolderName
		(	QuickListFolderName,
			Description)
		Values
		(	@QuickListFolderName,
			@Description)

		Set @pkFormQuickListFolderName = Scope_Identity()
	end

	Insert Into FormQuickListFolder
	(	fkFormQuickListFolder,
		fkFormUser,
		fkFormQuickListFolderName)
	Values
	(	@fkParentQuickListFolder,
		@fkFormUser,
		@pkFormQuickListFolderName)

	Set @pkQuickListFolder = Scope_Identity()
