----------------------------------------------------------------------------
-- Select a single record from CPAgencyAddress
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPAgencyAddressSelect]
	@pkCPAgencyAddress decimal(18, 0) = NULL,
	@fkCPRefAgencyAddressType decimal(18, 0) = NULL,
	@Street1 varchar(100) = NULL,
	@Street2 varchar(100) = NULL,
	@Street3 varchar(100) = NULL,
	@City varchar(100) = NULL,
	@State varchar(50) = NULL,
	@Zip char(5) = NULL,
	@ZipPlus4 char(4) = NULL

AS

SELECT	pkCPAgencyAddress,
	fkCPRefAgencyAddressType,
	Street1,
	Street2,
	Street3,
	City,
	State,
	Zip,
	ZipPlus4
FROM	CPAgencyAddress
WHERE 	(@pkCPAgencyAddress IS NULL OR pkCPAgencyAddress = @pkCPAgencyAddress)
 AND 	(@fkCPRefAgencyAddressType IS NULL OR fkCPRefAgencyAddressType = @fkCPRefAgencyAddressType)
 AND 	(@Street1 IS NULL OR Street1 LIKE @Street1 + '%')
 AND 	(@Street2 IS NULL OR Street2 LIKE @Street2 + '%')
 AND 	(@Street3 IS NULL OR Street3 LIKE @Street3 + '%')
 AND 	(@City IS NULL OR City LIKE @City + '%')
 AND 	(@State IS NULL OR State LIKE @State + '%')
 AND 	(@Zip IS NULL OR Zip LIKE @Zip + '%')
 AND 	(@ZipPlus4 IS NULL OR ZipPlus4 LIKE @ZipPlus4 + '%')
