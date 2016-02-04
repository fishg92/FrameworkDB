----------------------------------------------------------------------------
-- Insert a single record into CPClient
----------------------------------------------------------------------------
CREATE PROC uspCPClientInsert
(	  @LastName varchar(100) = NULL
	, @FirstName varchar(100) = NULL
	, @MiddleName varchar(100) = NULL
	, @SSN char(10) = NULL
	, @NorthwoodsNumber varchar(50) OUTPUT
	, @StateIssuedNumber varchar(50) = NULL
	, @BirthDate datetime = NULL
	, @BirthLocation varchar(100) = NULL
	, @Sex char(1) = NULL
	, @fkCPRefClientEducationType decimal(18, 0) = NULL
	, @LockedUser varchar(20) = NULL
	, @LockedDate datetime = NULL
	, @MaidenName varchar(100) = NULL
	, @Suffix varchar(20) = NULL
	, @SISNumber varchar(11) = NULL
	, @SchoolName varchar(100) = NULL
	, @HomePhone varchar(10) = NULL
	, @CellPhone varchar(10) = NULL
	, @WorkPhone varchar(10) = NULL
	, @WorkPhoneExt varchar(10) = NULL
	, @Email varchar(250) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPClient decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine


INSERT CPClient
(	  LastName
	, FirstName
	, MiddleName
	, SSN
	, NorthwoodsNumber
	, StateIssuedNumber
	, BirthDate
	, BirthLocation
	, Sex
	, fkCPRefClientEducationType
	, LockedUser
	, LockedDate
	, MaidenName
	, Suffix
	, SISNumber
	, SchoolName
	, HomePhone
	, CellPhone
	, WorkPhone
	, WorkPhoneExt
	, Email
)
VALUES 
(	  @LastName
	, @FirstName
	, @MiddleName
	, @SSN
	, @NorthwoodsNumber
	, @StateIssuedNumber
	, @BirthDate
	, @BirthLocation
	, @Sex
	, @fkCPRefClientEducationType
	, @LockedUser
	, @LockedDate
	, @MaidenName
	, @Suffix
	, @SISNumber
	, @SchoolName
	, COALESCE(@HomePhone, '')
	, COALESCE(@CellPhone, '')
	, COALESCE(@WorkPhone, '')
	, COALESCE(@WorkPhoneExt, '')
	, @Email

)

SET @pkCPClient = SCOPE_IDENTITY()
	Set @NorthwoodsNumber = dbo.GetNorthwoodsNumber(@pkCPClient)

	Update 	CPClient
	Set	NorthwoodsNumber = @NorthwoodsNumber
	Where	pkCPClient = @pkCPClient
