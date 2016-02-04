

CREATE   proc [dbo].[spCPInsertUpdateCPJoinClientNarrativeNT]
(
	@fkCPClient decimal(18,0),
	@fkCPNarrativeNT decimal(18,0),
	@pkCPJoinClientNarrativeNT decimal(18,0) output
)
as
If IsNull(@pkCPJoinClientNarrativeNT,0) = 0 
begin
	
	Insert into CPJoinClientNarrativeNT
	(	fkCPClient,
		fkCPNarrativeNT)
	Values
	(	@fkCPClient,
		@fkCPNarrativeNT)
	
	Set @pkCPJoinClientNarrativeNT = Scope_Identity()

end
Else
begin
	Update	CPJoinClientNarrativeNT
	Set	fkCPClient = @fkCPClient,
		fkCPNarrativeNT = @fkCPNarrativeNT
	Where	pkCPJoinClientNarrativeNT = @pkCPJoinClientNarrativeNT

end
