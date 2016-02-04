CREATE  Proc [dbo].[spCPInsertUpdateCPEmployer]
(	
	@EmployerName varchar(255),
	@Street1 varchar(100),
	@Street2 varchar(100),
	@Street3 varchar(100),
	@City varchar(100),
	@State varchar(50),
	@Zip char(5),
	@ZipPlus4 char(4),
	@Phone varchar(10),
	@Salary varchar(50),
	@pkCPEmployer decimal(18,0) Output
)
as

If IsNull(@pkCPEmployer,0) = 0
begin

	Insert Into CPEmployer
	(	
		EmployerName ,
		Street1,
		Street2,
		Street3,
		City,
		State,
		Zip,
		ZipPlus4,
		Phone,
		Salary)
	Values
	(	
		@EmployerName ,
		@Street1,
		@Street2,
		@Street3,
		@City,
		@State,
		@Zip,
		@ZipPlus4,
		@Phone,
		@Salary)
	
	Set @pkCPEmployer = Scope_Identity()

end
Else
begin

	Update	CPEmployer
	Set	
		EmployerName = @EmployerName,
		Street1 = @Street1,
		Street2 = @Street2,
		Street3 = @Street3,
		City = @City,
		State = @State,
		Zip = @Zip,
		ZipPlus4 = @ZipPlus4,
		Phone = @Phone,
		Salary = @Salary
	Where	pkCPEmployer = @pkCPEmployer

end



