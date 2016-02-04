CREATE  Proc [dbo].[spCPInsertUpdateCPRefMilitaryBranch]
(	
	@Description varchar(255),
	@pkCPRefMilitaryBranch decimal(18,0) Output
)
as

If IsNull(@pkCPRefMilitaryBranch,0) = 0
begin

	Insert Into CPRefMilitaryBranch
	(	
		[Description])
	Values
	(	
		@Description)
	
	Set @pkCPRefMilitaryBranch = Scope_Identity()

end
Else
begin

	Update	CPRefMilitaryBranch
	Set
		[Description] = @Description
	Where	pkCPRefMilitaryBranch = @pkCPRefMilitaryBranch

end



