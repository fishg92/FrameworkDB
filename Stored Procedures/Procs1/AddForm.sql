


/****** Object:  Stored Procedure dbo.AddForm    Script Date: 8/21/2006 8:02:14 AM ******/



CREATE  procedure [dbo].[AddForm]
(	@FormName varchar(500),
	@UserAdded varchar(100)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	,@pkForm decimal(18,0) output
)
as


exec dbo.SetAuditDataContext @LupUser, @LupMachine

	Declare @RETURNED_FORM_ID int

	If Exists(Select pkForm from Form where FormName = @FormName) 
	begin
		Set @pkForm = (Select pkForm from Form where FormName = @FormName)
	end
	Else
	begin
		Insert into dbo.Form
		(	FormName)
		values 
		(	@FormName)
	
		Set @pkForm = Scope_Identity()
	end
