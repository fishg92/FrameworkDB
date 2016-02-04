
CREATE  Proc [dbo].[spCPInsertUpdateCPClient]
(	
	@LastName varchar(100),
	@FirstName varchar(100),
	@MiddleName varchar(100),
	@SSN char(10),
	@NorthwoodsNumber varchar(50) output,
	@StateIssuedNumber varchar(50),
	@BirthDate datetime,
	@BirthLocation varchar(100),
	@Sex char(1),
	@fkCPRefClientEducationType decimal(18,0),
	@LockedDate smalldatetime = null,
	@LockedUser varchar(20) = null,
	@MaidenName Varchar(100) = Null,
	@pkCPClient decimal(18,0) output
)
as

If IsNull(@pkCPClient,0) = 0
begin

	Insert Into CPClient
	(	
		LastName,
		FirstName,
		MiddleName,
		SSN,
		StateIssuedNumber,
		BirthDate,
		BirthLocation,
		Sex,
		fkCPRefClientEducationType,
		LockedUser,
		LockedDate,
		MaidenName)
	Values
	(	
		@LastName,
		@FirstName,
		@MiddleName,
		@SSN,
		@StateIssuedNumber,
		@BirthDate,
		@BirthLocation,
		@Sex,
		@fkCPRefClientEducationType,
		@LockedUser,
		@LockedDate,
		@MaidenName)

	Set @pkCPClient = Scope_Identity()
	Set @NorthwoodsNumber = dbo.GetNorthwoodsNumber(@pkCPClient)

end
Else
begin
	Set @NorthwoodsNumber = dbo.GetNorthwoodsNumber(@pkCPClient) 

	Update 	CPClient
	Set	
		LastName = @LastName,
		FirstName = @FirstName,
		MiddleName = @MiddleName,
		SSN = @SSN,
		StateIssuedNumber = @StateIssuedNumber,
		NorthwoodsNumber = @NorthwoodsNumber,
		BirthDate = @BirthDate,
		BirthLocation = @BirthLocation,
		Sex = @Sex,
		fkCPRefClientEducationType = @fkCPRefClientEducationType,
		LockedUser = @LockedUser,
		LockedDate = @LockedDate,
		MaidenName = @MaidenName
	Where	pkCPClient = @pkCPClient

end