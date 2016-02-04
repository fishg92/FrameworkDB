CREATE proc [dbo].[spCPInsertUpdateCPCaseActivity]
(	@Description varchar(8000),
	@fkCPCaseActivityType decimal(18,0),
	@fkCPClientCase decimal(18,0),
	@fkCPClient decimal(18,0),
	@pkCPCaseActivity decimal(18,0) output
)
as

If IsNull(@pkCPCaseActivity,0) = 0 
begin
	
	INSERT INTO CPCaseActivity
	(	

		fkCPCaseActivityType,
		[Description],
		fkCPClientCase,
		fkCPClient)
	VALUES     
	(	

		@fkCPCaseActivityType,
		@Description,
		@fkCPClientCase,
		@fkCPClient)
	
	Set @pkCPCaseActivity = Scope_Identity()

end
Else
begin

	Update	CPCaseActivity
	Set	
		[Description] = @Description, 
		fkCPCaseActivityType = @fkCPCaseActivityType, 
		fkCPClientCase = @fkCPClientCase,
		fkCPClient = @fkCPClient
	Where	pkCPCaseActivity = @pkCPCaseActivity

end
