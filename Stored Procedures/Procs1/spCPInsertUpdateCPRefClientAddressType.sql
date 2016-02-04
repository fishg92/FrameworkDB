
CREATE  Proc [dbo].[spCPInsertUpdateCPRefClientAddressType]
(	
	@Description varchar(255),
	@pkCPRefClientAddressType decimal(18,0) Output
)
as

If IsNull(@pkCPRefClientAddressType,0) = 0
begin

	Insert Into CPRefClientAddressType
	(	
		[Description])
	Values
	(	
		@Description)
	
	Set @pkCPRefClientAddressType = Scope_Identity()

end
Else
begin

	Update	CPRefClientAddressType
	Set	
		[Description] = @Description
	Where	pkCPRefClientAddressType = @pkCPRefClientAddressType

end


