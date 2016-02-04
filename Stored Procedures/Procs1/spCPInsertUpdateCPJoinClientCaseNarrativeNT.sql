

CREATE   Proc [dbo].[spCPInsertUpdateCPJoinClientCaseNarrativeNT]
(	@fkCPClientCase decimal(18,0),
	@fkCPNarrativeNT decimal(18,0),
	@pkCPJoinClientCaseNarrativeNT decimal(18,0) output
)
as

If IsNull(@pkCPJoinClientCaseNarrativeNT,0) = 0
begin

	Insert Into CPJoinClientCaseNarrativeNT
	(	fkCPClientCase,
		fkCPNarrativeNT)
	Values
	(	@fkCPClientCase,
		@fkCPNarrativeNT)
	
	Set @pkCPJoinClientCaseNarrativeNT = Scope_Identity()

end
Else
begin

	Update 	CPJoinClientCaseNarrativeNT
	Set	fkCPClientCase = @fkCPClientCase,
		fkCPNarrativeNT = @fkCPNarrativeNT
	Where	pkCPJoinClientCaseNarrativeNT = @pkCPJoinClientCaseNarrativeNT

end
