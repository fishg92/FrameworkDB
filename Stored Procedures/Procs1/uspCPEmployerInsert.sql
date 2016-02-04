----------------------------------------------------------------------------
-- Insert a single record into CPEmployer
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPEmployerInsert]
(	  @EmployerName varchar(255) = NULL
	, @Street1 varchar(100) = NULL
	, @Street2 varchar(100) = NULL
	, @Street3 varchar(100) = NULL
	, @City varchar(100) = NULL
	, @State varchar(50) = NULL
	, @Zip char(5) = NULL
	, @ZipPlus4 char(4) = NULL
	, @Phone varchar(10) = NULL
	, @Salary varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPEmployer decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPEmployer
(	  EmployerName
	, Street1
	, Street2
	, Street3
	, City
	, State
	, Zip
	, ZipPlus4
	, Phone
	, Salary
)
VALUES 
(	  @EmployerName
	, @Street1
	, @Street2
	, @Street3
	, @City
	, @State
	, @Zip
	, @ZipPlus4
	, @Phone
	, @Salary

)

SET @pkCPEmployer = SCOPE_IDENTITY()
