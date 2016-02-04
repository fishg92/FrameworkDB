CREATE  Proc [dbo].[spCPInsertUpdateCPRefMarraigeEndType]
(	
	@Description varchar(255),
	@pkCPRefMarraigeEndType decimal(18,0) Output
)
as

If IsNull(@pkCPRefMarraigeEndType,0) = 0
begin

	Insert Into CPRefMarraigeEndType
	(	
		[Description])
	Values
	(	
		@Description)
	
	Set @pkCPRefMarraigeEndType = Scope_Identity()

end
Else
begin

	Update	CPRefMarraigeEndType
	Set	
		[Description] = @Description
	Where	pkCPRefMarraigeEndType = @pkCPRefMarraigeEndType

end



