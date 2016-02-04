----------------------------------------------------------------------------
-- Insert a single record into CPAgencyAddress
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPAgencyAddressInsert]
(	  @fkCPRefAgencyAddressType decimal(18, 0) = NULL
	, @Street1 varchar(100) = NULL
	, @Street2 varchar(100) = NULL
	, @Street3 varchar(100) = NULL
	, @City varchar(100) = NULL
	, @State varchar(50) = NULL
	, @Zip char(5) = NULL
	, @ZipPlus4 char(4) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPAgencyAddress decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPAgencyAddress
(	  fkCPRefAgencyAddressType
	, Street1
	, Street2
	, Street3
	, City
	, State
	, Zip
	, ZipPlus4
)
VALUES 
(	  @fkCPRefAgencyAddressType
	, @Street1
	, @Street2
	, @Street3
	, @City
	, @State
	, @Zip
	, @ZipPlus4

)

SET @pkCPAgencyAddress = SCOPE_IDENTITY()
