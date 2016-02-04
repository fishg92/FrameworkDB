CREATE Proc [dbo].[spCPGetCPClientAddress]
(	@Street1 varchar(100) = null,
	@Street2 varchar(100) = null,
	@Street3 varchar(100) = null,
	@City varchar(100) = null,
	@State varchar(50) = null,
	@Zip char(5) = null
)
as


Select 	pkCPClientAddress,
	CreateUser,
	CreateDate,
	LUPUser,
	LUPDate,
	fkCPRefClientAddressType,
	Street1,
	Street2,
	Street3,
	City,
	State,
	Zip,
	ZipPlus4,
	LockedUser,
	LockedDate
From	CPClientAddress c With (NoLock)
Where 	(@Street1 is null or c.Street1 like @Street1 + '%')
and   	(@Street2 is null or c.Street2 like @Street2 + '%')
and   	(@Street3 is null or c.Street3 like @Street3 + '%')
and   	(@City is null or c.City like @City + '%')
and   	(@State is null or c.State like @State + '%')
and   	(@Zip is null or c.Zip = @Zip)

