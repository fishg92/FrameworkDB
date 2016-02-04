
CREATE  Proc [dbo].[spCPInsertUpdateCPClientPhone]
(
	@fkCPRefPhoneType decimal(18,0),
	@Number varchar(10),
	@Extension varchar(10),
	@LockedUser varchar(50) = Null,
	@LockedDate datetime = Null,
	@pkCPClientPhone decimal(18,0) Output
)
as

If IsNull(@pkCPClientPhone,0) = 0 
begin

	Insert Into CPClientPhone
	(
		fkCPRefPhoneType,
		Number,
		Extension,
		LockedUser,
		LockedDate)
	Values
	(	
		@fkCPRefPhoneType,
		@Number,
		@Extension,
		@LockedUser,
		@LockedDate)
	
	Set @pkCPClientPhone = Scope_Identity()

end
Else
begin

	Update	CPClientPhone
	Set	
		fkCPRefPhoneType = @fkCPRefPhoneType,
		Number = @Number,
		Extension = @Extension,
		LockedUser = @LockedUser,
		LockedDate = @LockedDate
	Where	pkCPClientPhone = @pkCPClientPhone

end


