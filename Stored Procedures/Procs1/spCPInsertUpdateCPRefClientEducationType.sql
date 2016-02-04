CREATE  Proc [dbo].[spCPInsertUpdateCPRefClientEducationType]
(	
	@Description varchar(255),
	@pkCPRefClientEducationType decimal(18,0) Output
)
as

If IsNull(@pkCPRefClientEducationType,0) = 0
begin

	Insert Into CPRefClientEducationType
	(	
		[Description])
	Values
	(	
		@Description)
	
	Set @pkCPRefClientEducationType = Scope_Identity()

end
Else
begin

	Update	CPRefClientEducationType
	Set	
		[Description] = @Description
	Where	pkCPRefClientEducationType = @pkCPRefClientEducationType

end



