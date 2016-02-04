CREATE proc [dbo].[spCPGetCPClient]
(	@FirstName varchar(100) = null,
	@LastName varchar(100) = null,
	@SSN varchar(10) = null,
	@NorthwoodsNumber varchar(50) = null,
	@StateIssuedNumber varchar(50) = null,
	@BirthDate datetime = null
)
as


Select 	pkCPClient,
	CreateUser,
	CreateDate,
	LUPUser,
	LUPDate,
	LastName ,
	FirstName ,
	MiddleName,
	SSN,
	NorthwoodsNumber,
	StateIssuedNumber ,
	BirthDate ,
	Sex ,
	HomePhone ,
	CellPhone , 
	WorkPhone ,
	WorkPhoneExt,
	Email
	
From	CPClient c with (NoLock)
Where 	(@FirstName is null or c.FirstName like @FirstName + '%')
and   	(@LastName is null or c.LastName like @LastName + '%')
and   	(@SSN is null or c.SSN like @SSN + '%')
and   	(@NorthwoodsNumber is null or c.NorthwoodsNumber like @NorthwoodsNumber + '%')
and   	(@StateIssuedNumber is null or c.StateIssuedNumber like @StateIssuedNumber + '%')
and   	(@BirthDate is null or c.BirthDate = @BirthDate)
