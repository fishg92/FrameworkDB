----------------------------------------------------------------------------
-- Update a single record in CPClient
----------------------------------------------------------------------------
CREATE PROC uspCPClientUpdate
(	  @pkCPClient decimal(18, 0)
	, @LastName varchar(100) = NULL
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
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine


	Set @NorthwoodsNumber = dbo.GetNorthwoodsNumber(@pkCPClient) 


UPDATE	CPClient
SET	LastName = ISNULL(@LastName, LastName),
	FirstName = ISNULL(@FirstName, FirstName),
	MiddleName = ISNULL(@MiddleName, MiddleName),
	SSN = ISNULL(@SSN, SSN),
	NorthwoodsNumber = ISNULL(@NorthwoodsNumber, NorthwoodsNumber),
	StateIssuedNumber = ISNULL(@StateIssuedNumber, StateIssuedNumber),
	BirthDate = ISNULL(@BirthDate, BirthDate),
	BirthLocation = ISNULL(@BirthLocation, BirthLocation),
	Sex = ISNULL(@Sex, Sex),
	fkCPRefClientEducationType = ISNULL(@fkCPRefClientEducationType, fkCPRefClientEducationType),
	LockedUser = ISNULL(@LockedUser, LockedUser),
	LockedDate = ISNULL(@LockedDate, LockedDate),
	MaidenName = ISNULL(@MaidenName, MaidenName),
	Suffix = ISNULL(@Suffix, Suffix),
	SISNumber = ISNULL(@SISNumber, SISNumber),
	SchoolName = ISNULL(@SchoolName, SchoolName),
	HomePhone = ISNULL(@HomePhone, HomePhone),
	CellPhone = ISNULL(@CellPhone, CellPhone),
	WorkPhone = ISNULL(@WorkPhone, WorkPhone),
	WorkPhoneExt = ISNULL(@WorkPhoneExt, WorkPhoneExt),
	Email = ISNULL(@Email, Email)
WHERE 	pkCPClient = @pkCPClient
