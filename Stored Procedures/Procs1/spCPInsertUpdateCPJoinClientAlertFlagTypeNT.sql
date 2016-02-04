
CREATE  proc [dbo].[spCPInsertUpdateCPJoinClientAlertFlagTypeNT]
(
	@fkCPClient decimal(18,0),
	@fkRefCPAlertFlagTypeNT decimal(18,0),
	@pkCPJoinClientAlertFlagTypeNT decimal(18,0) output
)
as

If IsNull(@pkCPJoinClientAlertFlagTypeNT,0) = 0
begin
	
	Insert Into CPJoinClientAlertFlagTypeNT
	(	fkCPClient,
		fkRefCPAlertFlagTypeNT)
	Values
	(	@fkCPClient,
		@fkRefCPAlertFlagTypeNT)
	
	Set @pkCPJoinClientAlertFlagTypeNT = Scope_Identity()

end
Else
begin

	Update 	CPJoinClientAlertFlagTypeNT
	Set	fkCPClient = @fkCPClient,
		fkRefCPAlertFlagTypeNT = @fkRefCPAlertFlagTypeNT
	Where	pkCPJoinClientAlertFlagTypeNT = @pkCPJoinClientAlertFlagTypeNT

end
