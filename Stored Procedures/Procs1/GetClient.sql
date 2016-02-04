CREATE PROCEDURE [api].[GetClient]
	@ClientID decimal
AS

DECLARE  @pkCPClient decimal
		,@FirstName varchar(100)
		,@MiddleName varchar(100)
		,@LastName varchar(100)
		,@Suffix varchar(20)
		,@SSN char(10)
		,@StateIssuedNumber varchar(50)
		,@BirthDate datetime
		,@PhysicalAddress1 varchar(100)
		,@PhysicalAddress2 varchar(100)
		,@PhysicalCity varchar(100)
		,@PhysicalState varchar(50)
		,@PhysicalZip char(5)
		,@PhysicalZipPlus4 char(4)
		,@MailingAddress1 varchar(100)
		,@MailingAddress2 varchar(100)
		,@MailingCity varchar(100)
		,@MailingState varchar(50)
		,@MailingZip char(5)
		,@MailingZipPlus4 char(4)

SELECT   @pkCPClient = pkCPClient
		,@FirstName = FirstName
		,@MiddleName = MiddleName
		,@LastName = LastName
		,@Suffix = Suffix
		,@SSN = SSN
		,@StateIssuedNumber = StateIssuedNumber
		,@BirthDate = BirthDate
FROM CPClient
WHERE pkCPClient = @ClientID

SELECT   @PhysicalAddress1 = ad.Street1
		,@PhysicalAddress2 = ad.Street2
		,@PhysicalCity = ad.City
		,@PhysicalState = ad.[State]
		,@PhysicalZip = ad.Zip
		,@PhysicalZipPlus4 = ad.ZipPlus4
FROM CPClientAddress ad
JOIN CPJoinClientClientAddress j ON ad.pkCPClientAddress = j.fkCPClientAddress
WHERE j.fkCPClient = @ClientID
AND j.fkCPRefClientAddressType = 2

SELECT   @MailingAddress1 = ad.Street1
		,@MailingAddress2 = ad.Street2
		,@MailingCity = ad.City
		,@MailingState = ad.[State]
		,@MailingZip = ad.Zip
		,@MailingZipPlus4 = ad.ZipPlus4
FROM CPClientAddress ad
JOIN CPJoinClientClientAddress j ON ad.pkCPClientAddress = j.fkCPClientAddress
WHERE j.fkCPClient = @ClientID
AND j.fkCPRefClientAddressType = 1

IF @pkCPClient IS NOT NULL
BEGIN
	SELECT   pkCPClient = @pkCPClient
			,FirstName = @FirstName
			,MiddleName = @MiddleName
			,LastName = @LastName
			,Suffix = @Suffix
			,SSN = @SSN
			,StateIssuedNumber = @StateIssuedNumber
			,BirthDate = @BirthDate
			,PhysicalAddress1 = @PhysicalAddress1
			,PhysicalAddress2 = @PhysicalAddress2
			,PhysicalCity = @PhysicalCity
			,PhysicalState = @PhysicalState
			,PhysicalZip = @PhysicalZip
			,PhysicalZipPlus4 = @PhysicalZipPlus4
			,MailingAddress1 = @MailingAddress1
			,MailingAddress2 = @MailingAddress2
			,MailingCity = @MailingCity
			,MailingState = @MailingState
			,MailingZip = @MailingZip
			,MailingZipPlus4 = @MailingZipPlus4
END