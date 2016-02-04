





CREATE  procedure [dbo].[AddRendition]
(	@UserAdded varchar(50),
	@pkForm decimal(18,0),
	@UnFinished tinyint = null,
	@CaseNumber varchar(50) = null,
	@SSN varchar(50) = null,
	@FirstName varchar(50) = null,
	@LastName varchar(50) = null
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	,@pkRendition decimal(18,0) output
)
as

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	Insert into dbo.Rendition
	(	UserLUP,
		fkForm,
		UnFinished,
		CaseNumber,
		SSN,
		FirstName,
		LastName,
		DateLUP)
	Values
	(	@UserAdded,
		@pkForm,
		@UnFinished,
		@CaseNumber,
		@SSN,
		@FirstName,
		@LastName,
		GetDate())

	set @pkRendition = Scope_Identity()
