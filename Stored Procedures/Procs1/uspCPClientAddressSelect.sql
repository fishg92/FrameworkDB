----------------------------------------------------------------------------
-- Select a single record from CPClientAddress
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPClientAddressSelect]
(	@pkCPClientAddress decimal(18, 0) = NULL,
	@fkCPRefClientAddressType decimal(18, 0) = NULL,
	@Street1 varchar(100) = NULL,
	@Street2 varchar(100) = NULL,
	@Street3 varchar(100) = NULL,
	@City varchar(100) = NULL,
	@State varchar(50) = NULL,
	@Zip char(5) = NULL,
	@ZipPlus4 char(4) = NULL,
	@LockedUser varchar(50) = NULL,
	@LockedDate datetime = NULL
)
AS

SELECT	pkCPClientAddress,
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
FROM	CPClientAddress
WHERE 	(@pkCPClientAddress IS NULL OR pkCPClientAddress = @pkCPClientAddress)
 AND 	(@fkCPRefClientAddressType IS NULL OR fkCPRefClientAddressType = @fkCPRefClientAddressType)
 AND 	(@Street1 IS NULL OR Street1 LIKE @Street1 + '%')
 AND 	(@Street2 IS NULL OR Street2 LIKE @Street2 + '%')
 AND 	(@Street3 IS NULL OR Street3 LIKE @Street3 + '%')
 AND 	(@City IS NULL OR City LIKE @City + '%')
 AND 	(@State IS NULL OR State LIKE @State + '%')
 AND 	(@Zip IS NULL OR Zip LIKE @Zip + '%')
 AND 	(@ZipPlus4 IS NULL OR ZipPlus4 LIKE @ZipPlus4 + '%')
 AND 	(@LockedUser IS NULL OR LockedUser LIKE @LockedUser + '%')
 AND 	(@LockedDate IS NULL OR LockedDate = @LockedDate)
