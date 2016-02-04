
CREATE PROCEDURE [dbo].[uspCPImportFromStaging]
AS

SET NOCOUNT ON

EXEC dbo.spCPImportPreChecks

DECLARE
  @pkCPImportStaging decimal(18,0)
, @FirstName varchar(100)
, @MiddleName varchar(100)
, @LastName varchar(100)
, @Suffix varchar(20)
, @SSN char(10)
, @StateIssuedNumber varchar(20)
, @BirthDate datetime
, @BirthLocation varchar(100)
, @Sex char(1)
, @fkCPRefClientEducationType decimal(18,0)
, @MaidenName varchar(100)
, @SchoolName varchar(100)
, @MailingStreet1 varchar(100)
, @MailingStreet2 varchar(100)
, @MailingStreet3 varchar(100)
, @MailingCity varchar(100)
, @MailingState varchar(50)
, @MailingZip char(5)
, @MailingZipPlus4 char(4)
, @PhysicalStreet1 varchar(100)
, @PhysicalStreet2 varchar(100) 
, @PhysicalStreet3 varchar(100)
, @PhysicalCity varchar(100)
, @PhysicalState varchar(50)
, @PhysicalZip char(5)
, @PhysicalZipPlus4 char(4)
, @HomePhoneNumber varchar(10)
, @CellPhoneNumber varchar(10)
, @CaseWorkerNumber varchar(50)
, @CaseHead bit
, @StateCaseNumber varchar(20)
, @LocalCaseNumber varchar(20)
, @ProgramType decimal(18,0)
, @Data1 varchar(255), @Data2 varchar(255), @Data3 varchar(255), @Data4 varchar(255), @Data5 varchar(255), @Data6 varchar(255), @Data7 varchar(255), @Data8 varchar(255), @Data9 varchar(255), @Data10 varchar(255), @Data11 varchar(255), @Data12 varchar(255), @Data13 varchar(255), @Data14 varchar(255), @Data15 varchar(255), @Data16 varchar(255), @Data17 varchar(255), @Data18 varchar(255), @Data19 varchar(255), @Data20 varchar(255), @Data21 varchar(255), @Data22 varchar(255), @Data23 varchar(255), @Data24 varchar(255), @Data25 varchar(255), @Data26 varchar(255), @Data27 varchar(255), @Data28 varchar(255), @Data29 varchar(255), @Data30 varchar(255), @Data31 varchar(255), @Data32 varchar(255), @Data33 varchar(255), @Data34 varchar(255), @Data35 varchar(255), @Data36 varchar(255), @Data37 varchar(255), @Data38 varchar(255), @Data39 varchar(255), @Data40 varchar(255)

DECLARE   @ImportCursorFetchStatus int
		, @IndividualAlreadyProcessed bit
		, @pkCPClient decimal(18,0)
		, @pkCPClientCase decimal(18,0)
		, @fkClientCaseHead decimal(18,0)
		, @pkCPClientAddress decimal(18,0)


--skip any rows that don't have a matching program type
-- or the birthdate is invalid...but not null
UPDATE CPImportStaging SET IndividualProcessed = 1
WHERE dbo.fnGetpkProgramTypeFromString(ProgramType) = 0 OR
 ( ISDATE(BirthDate) = 0 AND ISNULL(BirthDate, '') <> '') OR
 ( DATEDIFF(dd,Birthdate,GETDATE()) < 0 AND ISNULL(BirthDate, '') <> '' ) OR
 ( DATEDIFF(dd,Birthdate,'1/1/1900') > 0 AND ISNULL(BirthDate, '') <> '')  
 


DECLARE ImportCursor CURSOR FOR
	SELECT pkCPImportStaging
	FROM CPImportStaging (NOLOCK)
	WHERE IndividualProcessed IS NULL OR IndividualProcessed = 0
	ORDER BY  ProgramType ASC
			, StateCaseNumber ASC
			, LocalCaseNumber ASC
			, CaseHead DESC
			
OPEN ImportCursor
FETCH FROM ImportCursor INTO @pkCPImportStaging
SET @ImportCursorFetchStatus = @@FETCH_STATUS



WHILE @ImportCursorFetchStatus = 0
BEGIN
	
--possibly do the trims here
	SELECT    @FirstName = FirstName 
			, @MiddleName = MiddleName 
			, @LastName = LastName
			, @Suffix = Suffix
			, @SSN = SSN
			, @StateIssuedNumber = UniqueID
			, @BirthDate =  Birthdate 
			, @BirthLocation = BirthLocation
			, @Sex = Sex
			, @fkCPRefClientEducationType = (SELECT pkCPRefClientEducationType FROM CPRefClientEducationType WHERE [Description] = Education)
			, @MaidenName = MaidenName
			, @SchoolName = SchoolName
			, @MailingStreet1 = MailingStreet1
			, @MailingStreet2 = MailingStreet2
			, @MailingStreet3 = MailingStreet3
			, @MailingCity = MailingCity
			, @MailingState = MailingState
			, @MailingZip = MailingZip
			, @MailingZipPlus4 = MailingZipPlus4
			, @PhysicalStreet1 = PhysicalStreet1
			, @PhysicalStreet2 = PhysicalStreet2
			, @PhysicalStreet3 = PhysicalStreet3
			, @PhysicalCity = PhysicalCity
			, @PhysicalState = PhysicalState
			, @PhysicalZip = PhysicalZip
			, @PhysicalZipPlus4 = PhysicalZipPlus4
			, @HomePhoneNumber = HomePhoneNumber
			, @CellPhoneNumber = CellPhoneNumber
			, @CaseWorkerNumber = CaseWorkerNumber
			, @CaseHead = CaseHead 
			, @StateCaseNumber = StateCaseNumber
			, @LocalCaseNumber = LocalCaseNumber 
			, @ProgramType = dbo.fnGetpkProgramTypeFromString(ProgramType)
			, @Data1 = Data1 , @Data2 = Data2 , @Data3 = Data3 , @Data4 = Data4 , @Data5 = Data5 , @Data6 = Data6 , @Data7 = Data7 , @Data8 = Data8 , @Data9 = Data9 , @Data10 = Data10 , @Data11 = Data11 , @Data12 = Data12 , @Data13 = Data13 , @Data14 = Data14 , @Data15 = Data15 , @Data16 = Data16 , @Data17 = Data17 , @Data18 = Data18 , @Data19 = Data19 , @Data20 = Data20 , @Data21 = Data21 , @Data22 = Data22 , @Data23 = Data23 , @Data24 = Data24 , @Data25 = Data25 , @Data26 = Data26 , @Data27 = Data27 , @Data28 = Data28 , @Data29 = Data29 , @Data30 = Data30 , @Data31 = Data31 , @Data32 = Data32 , @Data33 = Data33 , @Data34 = Data34 , @Data35 = Data35 , @Data36 = Data36 , @Data37 = Data37 , @Data38 = Data38 , @Data39 = Data39 , @Data40 = Data40
	FROM CPImportStaging
	WHERE pkCPImportStaging = @pkCPImportStaging



	EXEC uspCPImportClient @FirstName = @FirstName
						 , @LastName = @LastName
						 , @MiddleName = @MiddleName
						 , @Suffix = @Suffix
						 , @SSN = @SSN
						 , @BirthDate = @BirthDate
						 , @BirthLocation = @BirthLocation
						 , @StateIssuedNumber = @StateIssuedNumber
						 , @Sex = @Sex
						 , @fkCPRefClientEducationType = @fkCPRefClientEducationType
						 , @MaidenName = @MaidenName
						 , @SchoolName = @SchoolName
						 , @HomePhoneNumber = @HomePhoneNumber
						 , @CellPhoneNumber = @CellPhoneNumber
						 , @pkCPClient = @pkCPClient output
	
	
	If LEN(isnull(@StateCaseNumber,'')) <> 0
		BEGIN
			SELECT @fkClientCaseHead =  CASE @CaseHead
											WHEN 1 THEN @pkCPClient
											WHEN 0 THEN NULL
										END

			EXEC uspCPImportCase  @StateCaseNumber = @StateCaseNumber
								, @LocalCaseNumber = @LocalCaseNumber
								, @CaseWorkerNumber = @CaseWorkerNumber
								, @pkCPRefClientCaseProgramType = @ProgramType
								, @fkCPClientCaseHead = @fkClientCaseHead
								, @pkCPClientCase = @pkCPClientCase output
								
			EXEC uspCPImportJoinClientCase @fkCPClient = @pkCPClient
										 , @fkCPClientCase = @pkCPClientCase
										 , @PrimaryParticipantOnCase = @CaseHead
		END
	
	EXEC uspCPImportClientAddress @Street1 = @MailingStreet1
								, @Street2 = @MailingStreet2
								, @Street3 = @MailingStreet3
								, @City = @MailingCity
								, @State = @MailingState
								, @Zip = @MailingZip
								, @ZipPlus4 = @MailingZipPlus4
								, @pkCPRefAddressType = 1
								, @pkCPClient = @pkCPClient
	
	EXEC uspCPImportClientAddress @Street1 = @PhysicalStreet1
								, @Street2 = @PhysicalStreet2
								, @Street3 = @PhysicalStreet3
								, @City = @PhysicalCity
								, @State = @PhysicalState
								, @Zip = @PhysicalZip
								, @ZipPlus4 = @PhysicalZipPlus4
								, @pkCPRefAddressType = 2
								, @pkCPClient = @pkCPClient
/*								
	EXEC uspCPImportClientPhone   @pkCPClient = @pkCPClient
								, @PhoneNumber = @HomePhoneNumber
								, @fkCPRefPhoneType = 1

	EXEC uspCPImportClientPhone   @pkCPClient = @pkCPClient
								, @PhoneNumber = @CellPhoneNumber
								, @fkCPRefPhoneType = 3
*/
								
	EXEC uspCPImportClientCustom  @fkCPClient = @pkCPClient
								, @DATA1  = @DATA1
								, @DATA2  = @DATA2
								, @DATA3  = @DATA3
								, @DATA4  = @DATA4
								, @DATA5  = @DATA5
								, @DATA6  = @DATA6
								, @DATA7  = @DATA7
								, @DATA8  = @DATA8
								, @DATA9  = @DATA9
								, @DATA10  = @DATA10
								, @DATA11  = @DATA11
								, @DATA12  = @DATA12
								, @DATA13  = @DATA13
								, @DATA14  = @DATA14
								, @DATA15  = @DATA15
								, @DATA16  = @DATA16
								, @DATA17  = @DATA17
								, @DATA18  = @DATA18
								, @DATA19  = @DATA19
								, @DATA20  = @DATA20
								, @DATA21  = @DATA21
								, @DATA22  = @DATA22
								, @DATA23  = @DATA23
								, @DATA24  = @DATA24
								, @DATA25  = @DATA25
								, @DATA26  = @DATA26
								, @DATA27  = @DATA27
								, @DATA28  = @DATA28
								, @DATA29  = @DATA29
								, @DATA30  = @DATA30
								, @DATA31  = @DATA31
								, @DATA32  = @DATA32
								, @DATA33  = @DATA33
								, @DATA34  = @DATA34
								, @DATA35  = @DATA35
								, @DATA36  = @DATA36
								, @DATA37  = @DATA37
								, @DATA38  = @DATA38
								, @DATA39  = @DATA39
								, @DATA40  = @DATA40
	
	UPDATE CPImportStaging
	SET IndividualProcessed = 1
	WHERE pkCPImportStaging = @pkCPImportStaging

	FETCH FROM ImportCursor INTO @pkCPImportStaging
	SET @ImportCursorFetchStatus = @@FETCH_STATUS
END

CLOSE ImportCursor
DEALLOCATE ImportCursor
