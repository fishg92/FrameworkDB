
CREATE  Proc [dbo].[spCPInsertUpdateCPRefPhoneType]
(	
	@Description varchar(255),
	@pkCPRefPhoneType decimal(18,0) Output
)
as

If IsNull(@pkCPRefPhoneType,0) = 0 
begin
	
	Insert Into CPRefPhoneType
	(	
		[Description])
	Values
	(	
		@Description)
	
	Set @pkCPRefPhoneType = Scope_Identity()

end
Else
begin

	Update 	CPRefPhoneType
	Set	
		[Description] = @Description
	Where	pkCPRefPhoneType = @pkCPRefPhoneType

end


