
CREATE  Proc [dbo].[spCPInsertUpdateCPRefClientCaseProgramType]
(	
	@Description varchar(255),
	@pkCPRefClientCaseProgramType decimal(18,0) Output
)
as

If IsNull(@pkCPRefClientCaseProgramType, 0) = 0 
begin
	
	Insert Into CPRefClientCaseProgramType
	(	
		[Description])
	Values
	(	
		@Description)
	
	Set @pkCPRefClientCaseProgramType = Scope_Identity()

end
Else
begin

	Update	CPRefClientCaseProgramType
	Set	
		[Description] = @Description
	Where	pkCPRefClientCaseProgramType = @pkCPRefClientCaseProgramType

end

