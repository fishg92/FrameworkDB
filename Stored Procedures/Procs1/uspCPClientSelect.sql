----------------------------------------------------------------------------
-- Select a single record from CPClient
----------------------------------------------------------------------------
CREATE PROC uspCPClientSelect
(	@pkCPClient decimal(18, 0) = NULL,
	@LastName varchar(100) = NULL,
	@FirstName varchar(100) = NULL,
	@MiddleName varchar(100) = NULL,
	@SSN char(10) = NULL,
	@NorthwoodsNumber varchar(50) = NULL,
	@StateIssuedNumber varchar(50) = NULL,
	@BirthDate datetime = NULL,
	@BirthLocation varchar(100) = NULL,
	@Sex char(1) = NULL,
	@fkCPRefClientEducationType decimal(18, 0) = NULL,
	@LockedUser varchar(20) = NULL,
	@LockedDate datetime = NULL,
	@FormattedSSN varchar(11) = NULL,
	@MaidenName varchar(100) = NULL,
	@Suffix varchar(20) = NULL,
	@SISNumber varchar(11) = NULL,
	@SchoolName varchar(100) = NULL,
	@HomePhone varchar(10) = NULL,
	@CellPhone varchar(10) = NULL,
	@WorkPhone varchar(10) = NULL,
	@WorkPhoneExt varchar(10) = NULL,
	@DataCheckSum int = NULL,
	@Email varchar(250) = NULL
)
AS

SELECT	pkCPClient,
	LastName,
	FirstName,
	MiddleName,
	SSN,
	NorthwoodsNumber,
	StateIssuedNumber,
	BirthDate,
	BirthLocation,
	Sex,
	fkCPRefClientEducationType,
	LockedUser,
	LockedDate,
	FormattedSSN,
	MaidenName,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate,
	Suffix,
	SISNumber,
	SchoolName,
	HomePhone,
	CellPhone,
	WorkPhone,
	WorkPhoneExt,
	DataCheckSum,
	Email
FROM	CPClient
WHERE 	(@pkCPClient IS NULL OR pkCPClient = @pkCPClient)
 AND 	(@LastName IS NULL OR LastName LIKE @LastName + '%')
 AND 	(@FirstName IS NULL OR FirstName LIKE @FirstName + '%')
 AND 	(@MiddleName IS NULL OR MiddleName LIKE @MiddleName + '%')
 AND 	(@SSN IS NULL OR SSN LIKE @SSN + '%')
 AND 	(@NorthwoodsNumber IS NULL OR NorthwoodsNumber LIKE @NorthwoodsNumber + '%')
 AND 	(@StateIssuedNumber IS NULL OR StateIssuedNumber LIKE @StateIssuedNumber + '%')
 AND 	(@BirthDate IS NULL OR BirthDate = @BirthDate)
 AND 	(@BirthLocation IS NULL OR BirthLocation LIKE @BirthLocation + '%')
 AND 	(@Sex IS NULL OR Sex LIKE @Sex + '%')
 AND 	(@fkCPRefClientEducationType IS NULL OR fkCPRefClientEducationType = @fkCPRefClientEducationType)
 AND 	(@LockedUser IS NULL OR LockedUser LIKE @LockedUser + '%')
 AND 	(@LockedDate IS NULL OR LockedDate = @LockedDate)
 AND 	(@FormattedSSN IS NULL OR FormattedSSN LIKE @FormattedSSN + '%')
 AND 	(@MaidenName IS NULL OR MaidenName LIKE @MaidenName + '%')
 AND 	(@Suffix IS NULL OR Suffix LIKE @Suffix + '%')
 AND 	(@SISNumber IS NULL OR SISNumber LIKE @SISNumber + '%')
 AND 	(@SchoolName IS NULL OR SchoolName LIKE @SchoolName + '%')
 AND 	(@HomePhone IS NULL OR HomePhone LIKE @HomePhone + '%')
 AND 	(@CellPhone IS NULL OR CellPhone LIKE @CellPhone + '%')
 AND 	(@WorkPhone IS NULL OR WorkPhone LIKE @WorkPhone + '%')
 AND 	(@WorkPhoneExt IS NULL OR WorkPhoneExt LIKE @WorkPhoneExt + '%')
 AND 	(@DataCheckSum IS NULL OR DataCheckSum = @DataCheckSum)
 AND 	(@Email IS NULL OR Email LIKE @Email + '%')

