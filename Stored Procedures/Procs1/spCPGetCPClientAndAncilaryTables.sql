





--exec spCPGetCPClientAndAncilaryTables @SSN = '111111111', @pkCase = 1746
CREATE       proc [dbo].[spCPGetCPClientAndAncilaryTables]
(	@FirstName varchar(100) = null,
	@LastName varchar(100) = null,
	@SSN varchar(10) = null,
	@NorthwoodsNumber varchar(50) = null,
	@StateIssuedNumber varchar(50) = null,
	@BirthDate datetime = null,
	@pkCase decimal(18,0) = null
)
as

set nocount on

Declare @t table
(	ClientpkCPClient decimal(18, 0),
	ClientCreateUser varchar(50),
	ClientCreateDate datetime,
	ClientLUPUser varchar(50),
	ClientLUPDate datetime,
	ClientLastName varchar(100),
	ClientFirstName varchar(100),
	ClientMiddleName varchar(100),
	ClientSSN char(10),
	ClientNorthwoodsNumber varchar(50),
	ClientStateIssuedNumber varchar(50),
	ClientBirthDate datetime,
	ClientBirthLocation varchar(100),
	ClientSex char(1),
	ClientfkCPRefClientEducationType decimal(18, 0),
	ClientLockedUser varchar(50),
	ClientLockedDate datetime,
	ClientMaidenName Varchar(100),
	ClientSuffix Varchar(20),
	ClientSISNumber varchar(11),
	ClientSchoolName varchar(100),
	ClientHomePhone varchar(10), 
	ClientCellPhone varchar(10), 
	ClientWorkPhone varchar(10),
	ClientWorkPhoneExt varchar(10),
	ClientEmail varchar(250),

	JoinAddresspkCPJoinClientClientAddress decimal(18, 0),
	JoinAddressCreateUser varchar (50),
	JoinAddressCreateDate datetime,
	JoinAddressLUPUser varchar (50),
	JoinAddressLUPDate datetime,
	JoinAddressfkCPClient decimal(18, 0),
	JoinAddressfkCPClientAddress decimal(18, 0),
	JoinAddressLockedUser varchar(50),
	JoinAddressLockedDate datetime,

	AddresspkCPClientAddress decimal(18, 0),
	AddressCreateUser varchar (50),
	AddressCreateDate datetime,
	AddressLUPUser varchar (50),
	AddressLUPDate datetime,
	AddressfkCPRefClientAddressType decimal(18, 0),
	AddressStreet1 varchar (100),
	AddressStreet2 varchar (100),
	AddressStreet3 varchar (100),
	AddressCity varchar (100),
	AddressState varchar (50),
	AddressZip char (5),
	AddressZipPlus4 char (4),
	AddressLockedUser varchar(50),
	AddressLockedDate datetime,

	JoinClientPhonepkCPJoinClientClientPhone decimal(18, 0),
	JoinClientPhoneCreateUser varchar (50),
	JoinClientPhoneCreateDate datetime,
	JoinClientPhoneLUPUser varchar (50),
	JoinClientPhoneLUPDate datetime,
	JoinClientPhonefkCPClient decimal(18, 0),
	JoinClientPhonefkCPClientPhone decimal(18, 0),
	JoinClientPhoneLockedUser varchar(50),
	JoinClientPhoneLockedDate datetime,

	ClientPhonepkCPClientPhone decimal(18, 0),
	ClientPhoneCreateUser varchar (50),
	ClientPhoneCreateDate datetime,
	ClientPhoneLUPUser varchar (50),
	ClientPhoneLUPDate datetime,
	ClientPhonefkCPRefPhoneType decimal(18, 0),
	ClientPhoneNumber varchar (10),
	ClientPhoneExtension varchar (10),
	ClientPhoneLockedUser varchar(50),
	ClientPhoneLockedDate datetime,

	ClientPhoneTypepkCPRefClientPhoneType decimal(18, 0),
	ClientPhoneTypeCreateUser varchar (50) ,
	ClientPhoneTypeCreateDate datetime ,
	ClientPhoneTypeLUPUser varchar (50) ,
	ClientPhoneTypeLUPDate datetime ,
	ClientPhoneTypeDescription varchar (255),	

	AddressTypepkCPRefClientAddressType decimal(18, 0),
	AddressTypeCreateUser varchar (50) ,
	AddressTypeCreateDate datetime ,
	AddressTypeLUPUser varchar (50) ,
	AddressTypeLUPDate datetime ,
	AddressTypeDescription varchar (255),

	JoinClientEmployerpkCPJoinClientEmployer decimal(18, 0),
	JoinClientEmployerCreateUser varchar (50),
	JoinClientEmployerCreateDate datetime ,
	JoinClientEmployerLUPUser varchar (50) ,
	JoinClientEmployerLUPDate datetime ,
	JoinClientEmployerfkCPClient decimal(18, 0) ,
	JoinClientEmployerfkCPEmployer decimal(18, 0) ,
	JoinClientEmployerStartDate datetime,
	JoinClientEmployerEndDate datetime,
	JoinClientEmployerLockedUser varchar(50),
	JoinClientEmployerLockedDate datetime,

	EmployerpkCPEmployer decimal(18, 0) ,
	EmployerCreateUser varchar(50) ,
	EmployerCreateDate datetime ,
	EmployerLUPUser varchar(50)  ,
	EmployerLUPDate datetime  ,
	EmployerEmployerName varchar(255),
	EmployerStreet1 varchar(100),
	EmployerStreet2 varchar(100),
	EmployerStreet3 varchar(100),
	EmployerCity varchar(100),
	EmployerState varchar(50),
	EmployerZip char(5),
	EmployerZipPlus4 char(4),
	EmployerPhone varchar(10),
	EmployerSalary varchar(50)
)

Declare @CurrentDate Datetime
Set @CurrentDate = GetDate()

Insert Into 	@t

	Select 	c.pkCPClient,
		c.CreateUser,
		c.CreateDate,
		c.LUPUser,
		c.LUPDate,
		c.LastName,
		c.FirstName,
		c.MiddleName,
		c.SSN,
		c.NorthwoodsNumber,
		c.StateIssuedNumber,
		c.BirthDate,
		c.BirthLocation,
		c.Sex,
		c.fkCPRefClientEducationType,
		c.LockedUser,
		c.LockedDate,
		c.MaidenName,
		c.Suffix,
		c.SISNumber,
		c.SchoolName,
		c.HomePhone ,
		c.CellPhone , 
		c.WorkPhone ,
		c.WorkPhoneExt,
		c.Email,

		cja.pkCPJoinClientClientAddress,
		cja.CreateUser,
		cja.CreateDate,
		cja.LUPUser,
		cja.LUPDate,
		cja.fkCPClient,
		cja.fkCPClientAddress,
		cja.LockedUser,
		cja.LockedDate,
	
		a.pkCPClientAddress,
		a.CreateUser,
		a.CreateDate,
		a.LUPUser,
		a.LUPDate,
		a.fkCPRefClientAddressType,
		a.Street1,
		a.Street2,
		a.Street3,
		a.City,
		a.State,
		a.Zip,
		a.ZipPlus4,
		a.LockedUser,
		a.LockedDate,
	
		cjp.pkCPJoinClientClientPhone,
		cjp.CreateUser,
		cjp.CreateDate,
		cjp.LUPUser,
		cjp.LUPDate,
		cjp.fkCPClient,
		cjp.fkCPClientPhone,
		cjp.LockedUser,
		cjp.LockedDate,
	
		p.pkCPClientPhone,
		p.CreateUser,
		p.CreateDate,
		p.LUPUser,
		p.LUPDate,
		cjp.fkCPRefPhoneType,
		p.Number,
		p.Extension,
		p.LockedUser,
		p.LockedDate,
	
		rp.pkCPRefPhoneType,
		rp.CreateUser,
		rp.CreateDate,
		rp.LUPUser,
		rp.LUPDate,
		rp.Description,	
	
		ra.pkCPRefClientAddressType,
		ra.CreateUser,
		ra.CreateDate,
		ra.LUPUser,
		ra.LUPDate,
		ra.Description,
	
		ce.pkCPJoinClientEmployer,
		ce.CreateUser,
		ce.CreateDate,
		ce.LUPUser,
		ce.LUPDate ,
		ce.fkCPClient,
		ce.fkCPEmployer,
		ce.StartDate,
		ce.EndDate,
		ce.LockedUser,
		ce.LockedDate,

		e.pkCPEmployer,
		e.CreateUser,
		e.CreateDate,
		e.LUPUser,
		e.LUPDate,
		e.EmployerName,
		e.Street1,
		e.Street2,
		e.Street3,
		e.City,
		e.State,
		e.Zip,
		e.ZipPlus4,
		e.Phone,
		e.Salary 

From		CPClient c with (NoLock)
Left Join	CPJoinClientClientAddress cja with (NoLock) on cja.fkCPClient = c.pkCPClient
Left Join	CPClientAddress a with (NoLock) on a.pkCPClientAddress = cja.fkCPClientAddress
Left Join	CPJoinClientClientPhone cjp with (NoLock) on cjp.fkCPClient = c.pkCPClient
Left Join	CPClientPhone p with (NoLock) on p.pkCPClientPhone = cjp.fkCPClientPhone
Left Join	CPRefPhoneType rp with (NoLock) on rp.pkCPRefPhoneType = p.fkCPRefPhoneType
Left Join	CPRefClientAddressType ra with (NoLock) on ra.pkCPRefClientAddressType = a.fkCPRefClientAddressType
Left Join 	CPJoinClientEmployer ce with (NoLock) on c.pkCPClient = ce.fkCPClient
Left Join 	CPEmployer e with (NoLock) on ce.fkCPEmployer = e.pkCPEmployer

/*
From		dbo.pitCPClient(@CurrentDate,Null) c
Left Join	dbo.pitCPJoinClientClientAddress(@CurrentDate,Null) cja on cja.fkCPClient = c.pkCPClient
Left Join	dbo.pitCPClientAddress(@CurrentDate,Null) a on a.pkCPClientAddress = cja.fkCPClientAddress
Left Join	dbo.pitCPJoinClientClientPhone(@CurrentDate,Null) cjp on cjp.fkCPClient = c.pkCPClient
Left Join	dbo.pitCPClientPhone(@CurrentDate,Null) p on p.pkCPClientPhone = cjp.fkCPClientPhone
Left Join	dbo.pitCPRefPhoneType(@CurrentDate,Null) rp on rp.pkCPRefPhoneType = p.fkCPRefPhoneType
Left Join	dbo.pitCPRefClientAddressType(@CurrentDate,Null) ra on ra.pkCPRefClientAddressType = a.fkCPRefClientAddressType
*/

Where 		(@FirstName is null or c.FirstName like @FirstName + '%')
and   		(@LastName is null or c.LastName like @LastName + '%')
and   		(@SSN is null or c.SSN like @SSN + '%')
and   		(@NorthwoodsNumber is null or c.NorthwoodsNumber like @NorthwoodsNumber + '%')
and   		(@StateIssuedNumber is null or c.StateIssuedNumber like @StateIssuedNumber + '%')
and   		(@BirthDate is null or c.BirthDate = @BirthDate)

if isnull(@pkCase, 0) <> 0
	begin
		delete from @t
		where ClientpkCPClient in (select fkCPClient from CPJoinClientClientCase (nolock)
									where fkCPClientCase = @pkCase)
	end

Select Distinct	pkCPClient = ClientpkCPClient,
		CreateUser = ClientCreateUser,
		CreateDate = ClientCreateDate,
		LUPUser = ClientLUPUser,
		LUPDate = ClientLUPDate,
		LastName = ClientLastName,
		FirstName = ClientFirstName,
		MiddleName = ClientMiddleName,
		SSN = ClientSSN,
		NorthwoodsNumber = ClientNorthwoodsNumber,
		StateIssuedNumber = ClientStateIssuedNumber,
		BirthDate = ClientBirthDate,
		Sex = ClientSex,
		fkCPRefClientEducationType = ClientfkCPRefClientEducationType,
		LockedUser = ClientLockedUser,
		LockedDate = ClientLockedDate,
		MaidenName = Isnull(ClientMaidenName, ''),
		Suffix = Isnull(ClientSuffix, ''),
		SISNumber = Isnull(ClientSISNumber, ''),
		SchoolName = Isnull(ClientSchoolName, ''), 
		HomePhone = ClientHomePhone ,
		CellPhone = ClientCellPhone , 
		WorkPhone = ClientWorkPhone ,
		WorkPhoneExt = ClientWorkPhoneExt,
		Email = ISNULL(ClientEmail, '')
From 	@t
Where	IsNull(ClientpkCPClient,0) <> 0

Select Distinct	pkCPJoinClientClientAddress = JoinAddresspkCPJoinClientClientAddress,
		CreateUser = JoinAddressCreateUser,
		CreateDate = JoinAddressCreateDate,
		LUPUser = JoinAddressLUPUser,
		LUPDate = JoinAddressLUPDate,
		fkCPClient = JoinAddressfkCPClient,
		fkCPClientAddress = JoinAddressfkCPClientAddress,
		LockedUser = JoinAddressLockedUser,
		LockedDate = JoinAddressLockedDate
From 	@t
Where	IsNull(JoinAddresspkCPJoinClientClientAddress,0) <> 0

Select Distinct	pkCPClientAddress = AddresspkCPClientAddress,
		CreateUser = AddressCreateUser,
		CreateDate = AddressCreateDate,
		LUPUser = AddressLUPUser,
		LUPDate = AddressLUPDate,
		fkCPRefClientAddressType = AddressfkCPRefClientAddressType ,
		Street1 = AddressStreet1,
		Street2 = AddressStreet2 ,
		Street3 = AddressStreet3,
		City = AddressCity,
		State = AddressState,
		Zip = AddressZip,
		ZipPlus4 = AddressZipPlus4,
		LockedUser = AddressLockedUser,
		LockedDate = AddressLockedDate
From	@t
Where	IsNull(AddresspkCPClientAddress,0) <> 0

Select Distinct	pkCPJoinClientClientPhone = JoinClientPhonepkCPJoinClientClientPhone,
		CreateUser = JoinClientPhoneCreateUser ,
		CreateDate = JoinClientPhoneCreateDate ,
		LUPUser = JoinClientPhoneLUPUser ,
		LUPDate = JoinClientPhoneLUPDate ,
		fkCPClient = JoinClientPhonefkCPClient,
		fkCPClientPhone = JoinClientPhonefkCPClientPhone,
		LockedUser = JoinClientPhoneLockedUser,
		LockedDate = JoinClientPhoneLockedDate
From	@t
Where	IsNull(JoinClientPhonepkCPJoinClientClientPhone,0) <> 0

Select Distinct	pkCPClientPhone = ClientPhonepkCPClientPhone,
		CreateUser = ClientPhoneCreateUser,
		CreateDate = ClientPhoneCreateDate,
		LUPUser = ClientPhoneLUPUser,
		LUPDate = ClientPhoneLUPDate,
		fkCPRefPhoneType = ClientPhonefkCPRefPhoneType ,
		Number = ClientPhoneNumber,
		Extension = ClientPhoneExtension,
		LockedUser = ClientPhoneLockedUser,
		LockedDate = ClientPhoneLockedDate
From	@t
Where 	IsNull(ClientPhonepkCPClientPhone,0) <> 0

Select Distinct	pkCPRefClientPhoneType = ClientPhoneTypepkCPRefClientPhoneType,
		CreateUser = ClientPhoneTypeCreateUser,
		CreateDate = ClientPhoneTypeCreateDate ,
		LUPUser = ClientPhoneTypeLUPUser,
		LUPDate = ClientPhoneTypeLUPDate,
		[Description] = ClientPhoneTypeDescription
From	@t
Where	IsNull(ClientPhoneTypepkCPRefClientPhoneType,0) <> 0

Select Distinct	pkCPRefClientAddressType = AddressTypepkCPRefClientAddressType,
		CreateUser = AddressTypeCreateUser,
		CreateDate = AddressTypeCreateDate,
		LUPUser = AddressTypeLUPUser,
		LUPDate = AddressTypeLUPDate, 
		[Description] = AddressTypeDescription
From	@t
Where	IsNull(AddressTypepkCPRefClientAddressType,0) <> 0

Select Distinct	pkCPJoinClientEmployer = JoinClientEmployerpkCPJoinClientEmployer,
		CreateUser = JoinClientEmployerCreateUser,
		CreateDate = JoinClientEmployerCreateDate,
		LUPUser = JoinClientEmployerLUPUser,
		LUPDate = JoinClientEmployerLUPDate,
		fkCPClient = JoinClientEmployerfkCPClient,
		fkCPEmployer = JoinClientEmployerfkCPEmployer,
		StartDate = JoinClientEmployerStartDate,
		EndDate = JoinClientEmployerEndDate,
		LockedUser = JoinClientEmployerLockedUser,
		LockedDate = JoinClientEmployerLockedDate
From @t
Where IsNull(JoinClientEmployerpkCPJoinClientEmployer,0) <> 0

Select Distinct	pkCPEmployer = EmployerpkCPEmployer,
		CreateUser = EmployerCreateUser,
		CreateDate = EmployerCreateDate,
		LUPUser = EmployerLUPUser,
		LUPDate = EmployerLUPDate,
		EmployerName = EmployerEmployerName,
		Street1 = EmployerStreet1,
		Street2 = EmployerStreet2,
		Street3 = EmployerStreet3,
		City = EmployerCity,
		State = EmployerState,
		Zip = EmployerZip,
		ZipPlus4 = EmployerZipPlus4,
		Phone = EmployerPhone,
		Salary = EmployerSalary
From @t
Where IsNull(EmployerpkCPEmployer,0) <> 0
