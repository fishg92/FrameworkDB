CREATE PROCEDURE [dbo].[uspCPImportClient]
(
	  @FirstName varchar(50)
	, @LastName varchar(50)
	, @MiddleName varchar(50)
	, @Suffix varchar(20)
	, @SSN varchar(10)
	, @BirthDate datetime
	, @BirthLocation varchar(100)
	, @StateIssuedNumber varchar(50)
	, @Sex char(1)
	, @fkCPRefClientEducationType decimal(18,0)
	, @MaidenName varchar(100)
	, @SchoolName varchar(100)
	, @HomePhoneNumber varchar(10) 
	, @CellPhoneNumber varchar(10)  
	, @pkCPClient decimal (18,0) output
)
AS

SET NOCOUNT ON

DECLARE   @FirstNameFormatted varchar(50)
		, @LastNameFormatted varchar(50)
		, @MiddleNameFormatted varchar(50)
		, @StateIssuedNumberFormatted varchar(50)
		, @SexFormatted char(1)
		, @pkCPImportLog decimal
		, @BirthDateFormatted datetime
		, @LastNameCurrent varchar(100)
		, @FirstNameCurrent varchar(100)
		, @MiddleNameCurrent varchar(100)
		, @SSNCurrent char(10)
		, @StateIssuedNumberCurrent varchar(50)
		, @BirthDateCurrent datetime
		, @BirthLocationCurrent varchar(100)
		, @SexCurrent char(1)
		, @fkCPRefClientEducationTypeCurrent decimal
		, @MaidenNameCurrent varchar(100)
		, @SuffixCurrent varchar(20)
		, @SISNumberCurrent varchar(11)
		, @SchoolNameCurrent varchar(100)
		, @HomePhoneNumberCurrent varchar(10)
		, @CellPhoneNumberCurrent varchar(10)
		, @HostName varchar(100)
		
SELECT @HostName = HOST_NAME()

IF ISDATE(@BirthDate) = 0
BEGIN
	SELECT @BirthDate = '1/1/1900'
END

set @HomePhoneNumber = ISNULL(@HomePhoneNumber ,'')
set @CellPhoneNumber = ISNULL(@CellPhoneNumber ,'')

SELECT @FirstNameFormatted = LTRIM(RTRIM(ISNULL(@FirstName,'')))
	 , @LastNameFormatted = LTRIM(RTRIM(ISNULL(@LastName,'')))
	 , @MiddleNameFormatted = LTRIM(RTRIM(ISNULL(@MiddleName,'')))
	 , @StateIssuedNumberFormatted = LTRIM(RTRIM(ISNULL(@StateIssuedNumber,'')))
	 , @SexFormatted = ISNULL(@Sex,' ')
	 , @BirthDateFormatted = ISNULL(@BirthDate,'1/1/1900')
		
SELECT @pkCPClient = [dbo].[fnCPImportFindClient](    @FirstNameFormatted 
													, @LastNameFormatted 
													, @MiddleNameFormatted 
													, @SSN 
													, @BirthDateFormatted
													, @StateIssuedNumberFormatted 
													, @SexFormatted 
												 )
IF @pkCPClient <> 0
BEGIN
	SELECT	  @LastNameCurrent = LastName
			, @FirstNameCurrent = FirstName
			, @MiddleNameCurrent = MiddleName
			, @SSNCurrent = SSN
			, @StateIssuedNumberCurrent = StateIssuedNumber
			, @BirthDateCurrent = BirthDate
			, @BirthLocationCurrent = BirthLocation
			, @SexCurrent = Sex
			, @fkCPRefClientEducationTypeCurrent = fkCPRefClientEducationType
			, @MaidenNameCurrent = MaidenName
			, @SuffixCurrent = Suffix
			, @SISNumberCurrent = SISNumber
			, @SchoolNameCurrent = SchoolName
			, @HomePhoneNumberCurrent = HomePhone
			, @CellPhoneNumberCurrent = CellPhone
	FROM CPClient (NOLOCK)
	WHERE pkCPClient = @pkCPClient	

	IF ISNULL(@LastNameCurrent,'') <> @LastNameFormatted
	OR ISNULL(@FirstNameCurrent,'') <> @FirstNameFormatted
	OR ISNULL(@MiddleNameCurrent,'') <> @MiddleNameFormatted
	OR ISNULL(@SSNCurrent,'') <> @SSN
	OR ISNULL(@StateIssuedNumberCurrent,'') <> @StateIssuedNumberFormatted
	OR ISNULL(@BirthDateCurrent,'1/1/1900') <> @BirthDate
	OR ISNULL(@BirthLocationCurrent,'') <> @BirthLocation
	OR ISNULL(@SexCurrent,' ') <> @Sex
	OR ISNULL(@fkCPRefClientEducationTypeCurrent,0) <> @fkCPRefClientEducationType
	OR ISNULL(@MaidenNameCurrent,'') <> @MaidenName
	OR ISNULL(@SuffixCurrent,'') <> @Suffix
	OR ISNULL(@SchoolNameCurrent,'') <> @SchoolName
	OR ((ISNULL(@HomePhoneNumberCurrent,'') <> @HomePhoneNumber) and (@HomePhoneNumber <> ''))
	OR ((ISNULL(@CellPhoneNumberCurrent,'') <> @CellPhoneNumber) and (@CellPhoneNumber <> ''))
	BEGIN
		EXEC dbo.uspCPClientUpdate @pkCPClient = @pkCPClient
								 , @LastName = @LastName
								 , @FirstName = @FirstName
								 , @MiddleName = @MiddleName
								 , @Suffix = @Suffix
								 , @SSN = @SSN
								 , @StateIssuedNumber = @StateIssuedNumber
								 , @BirthDate = @BirthDate
								 , @BirthLocation = @BirthLocation
								 , @Sex = @Sex
								 , @fkCPRefClientEducationType = @fkCPRefClientEducationType
								 , @MaidenName = @MaidenName
								 , @SchoolName = @SchoolName
								 , @HomePhone = @HomePhoneNumber
								 , @CellPhone = @CellPhoneNumber
								 , @LUPUser = @HostName
								 , @LUPMac = @HostName
								 , @LUPIP = @HostName
								 , @LUPMachine = @HostName
								 , @NorthwoodsNumber = 0
	END
END
ELSE
BEGIN
	EXEC dbo.uspCPClientInsert @LastName = @LastName
							 , @FirstName = @FirstName
							 , @MiddleName = @MiddleName
							 , @SSN = @SSN
							 , @StateIssuedNumber = @StateIssuedNumber
							 , @BirthDate = @BirthDate
							 , @BirthLocation = @BirthLocation
							 , @Sex = @Sex
							 , @fkCPRefClientEducationType = @fkCPRefClientEducationType
							 , @MaidenName = @MaidenName
							 , @Suffix = @Suffix
							 , @SchoolName = @SchoolName
							 , @HomePhone = @HomePhoneNumber
							 , @CellPhone = @CellPhoneNumber
							 , @LUPUser = @HostName
							 , @LUPMac = @HostName
							 , @LUPIP = @HostName
							 , @LUPMachine = @HostName
							 , @pkCPClient = @pkCPClient output
							 , @NorthwoodsNumber = 0
END