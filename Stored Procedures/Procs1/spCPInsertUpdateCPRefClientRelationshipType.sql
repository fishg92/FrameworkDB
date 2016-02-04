CREATE  Proc [dbo].[spCPInsertUpdateCPRefClientRelationshipType]
(	
	@Description varchar(255),
	@pkCPRefClientRelationshipType decimal(18,0) Output
)
as

If IsNull(@pkCPRefClientRelationshipType,0) = 0
begin

	Insert Into CPRefClientRelationshipType
	(	
		[Description])
	Values
	(	
		@Description)
	
	Set @pkCPRefClientRelationshipType = Scope_Identity()

end
Else
begin

	Update	CPRefClientRelationshipType
	Set	
		[Description] = @Description
	Where	pkCPRefClientRelationshipType = @pkCPRefClientRelationshipType

end



