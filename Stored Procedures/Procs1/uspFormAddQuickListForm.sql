-- Stored Procedure

CREATE proc [dbo].[uspFormAddQuickListForm]
(	@QuickListFormName varchar(255),
	@fkFormName decimal(18, 0),
	@fkFormUser decimal(18, 0),
	@FormOrder int
, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	,@pkFormQuickListFormName decimal(18, 0) output
)
as

exec dbo.SetAuditDataContext @LupUser, @LupMachine


	Insert Into FormQuickListFormName
	(	fkFormName,
		fkFormUser,
		QuickListFormName,
		FormOrder)
	Values
	(	@fkFormName,
		@fkFormUser,
		@QuickListFormName,
		@FormOrder)

	Set @pkFormQuickListFormName = Scope_Identity()
