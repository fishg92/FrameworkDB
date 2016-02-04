
CREATE  Proc [dbo].[spCPInsertUpdateCPRefAlertFlagTypeNT]
(
	@Description varchar(255),
	@AlertDisplay bit,
	@pkCPRefAlertFlagTypeNT decimal(18,0) output
)
as

If IsNull(@pkCPRefAlertFlagTypeNT,0) = 0
begin

	Insert Into CPRefAlertFlagTypeNT
	(	[Description],
		AlertDisplay)
	Values
	(	@Description,
		@AlertDisplay)
	
	Set @pkCPRefAlertFlagTypeNT = Scope_Identity()

end
Else
begin

	Update	CPRefAlertFlagTypeNT
	Set	[Description] = @Description,
		AlertDisplay = @AlertDisplay
	Where	pkCPRefAlertFlagTypeNT = @pkCPRefAlertFlagTypeNT

end
