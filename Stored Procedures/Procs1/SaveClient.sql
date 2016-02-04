CREATE PROCEDURE [api].[SaveClient]
	 @ClientID decimal
	,@FirstName varchar(100)
	,@MiddleName varchar(100)
	,@LastName varchar(100)
	,@SSN varchar(9)
	,@Suffix varchar(20)
	,@StateIssuedNumber varchar(50)
	,@BirthDate datetime = NULL
	,@Gender varchar(1)
	,@LUPUser varchar(50)
	,@PhysicalAddress1 varchar(100) = NULL
	,@PhysicalAddress2 varchar(100) = NULL
	,@PhysicalAddress3 varchar(100) = NULL
	,@PhysicalCity varchar(100) = NULL
	,@PhysicalState varchar(50) = NULL
	,@PhysicalZip varchar(5) = NULL
	,@PhysicalZipPlus4 varchar(4) = NULL
	,@MailingAddress1 varchar(100) = NULL
	,@MailingAddress2 varchar(100) = NULL
	,@MailingAddress3 varchar(100) = NULL
	,@MailingCity varchar(100) = NULL
	,@MailingState varchar(50) = NULL
	,@MailingZip varchar(5) = NULL
	,@MailingZipPlus4 varchar(4) = NULL
AS

EXEC dbo.SetAuditDataContext @AuditUser = @LUPUser, @AuditMachine = 'WebAPI'

IF @ClientID = 0
BEGIN
	SET @FirstName = ISNULL(@FirstName,'')
	SET @MiddleName = ISNULL(@MiddleName,'')
	SET @LastName = ISNULL(@LastName,'')
	SET @SSN = ISNULL(@SSN,'')
	SET @Suffix = ISNULL(@Suffix,'')
	SET @StateIssuedNumber = ISNULL(@StateIssuedNumber,'')

	INSERT INTO CPClient
	(
		 FirstName
		,MiddleName
		,LastName
		,SSN
		,Suffix
		,StateIssuedNumber
		,BirthDate
		,Sex
	)
	VALUES
	(
		 @FirstName
		,@MiddleName
		,@LastName
		,@SSN
		,@Suffix
		,@StateIssuedNumber
		,@BirthDate
		,@Gender
	)

	SET @ClientID = SCOPE_IDENTITY()

	DECLARE @NorthwoodsNumber varchar(50) = dbo.GetNorthwoodsNumber(@ClientID)

	UPDATE CPClient
	SET NorthwoodsNumber = @NorthwoodsNumber
	WHERE pkCPClient = @ClientID
END
ELSE
BEGIN
	UPDATE CPClient
	SET  FirstName = @FirstName
		,MiddleName = @MiddleName
		,LastName = @LastName
		,SSN = @SSN
		,Suffix = @Suffix
		,StateIssuedNumber = @StateIssuedNumber
		,BirthDate = @BirthDate
		,Sex = @Gender
	WHERE pkCPClient = @ClientID
END

IF @PhysicalAddress1 IS NOT NULL
OR @PhysicalAddress2 IS NOT NULL
OR @PhysicalAddress3 IS NOT NULL
OR @PhysicalCity IS NOT NULL
OR @PhysicalState IS NOT NULL
OR @PhysicalZip IS NOT NULL
OR @PhysicalZipPlus4 IS NOT NULL
BEGIN
	DECLARE @PhysicalAddressID decimal

	SELECT @PhysicalAddressID = fkCPClientAddress
	FROM CPJoinClientClientAddress
	WHERE fkCPClient = @ClientID
	AND fkCPRefClientAddressType = 2

	IF @PhysicalAddressID IS NULL
	BEGIN
		INSERT INTO CPClientAddress
		(
			 Street1
			,Street2
			,Street3
			,City
			,[State]
			,Zip
			,ZipPlus4
			,fkCPRefClientAddressType
		)
		VALUES
		(
			 ISNULL(@PhysicalAddress1,'')
			,ISNULL(@PhysicalAddress2,'')
			,ISNULL(@PhysicalAddress3,'')
			,ISNULL(@PhysicalCity,'')
			,ISNULL(@PhysicalState,'')
			,ISNULL(@PhysicalZip,'')
			,ISNULL(@PhysicalZipPlus4,'')
			,2
		)
		
		SET @PhysicalAddressID = SCOPE_IDENTITY()

		INSERT INTO CPJoinClientClientAddress
		(
			 fkCPClient
			,fkCPClientAddress
			,fkCPRefClientAddressType
		)
		VALUES
		(
			 @ClientID
			,@PhysicalAddressID
			,2
		)
	END
	ELSE
	BEGIN
		UPDATE CPClientAddress
		SET  Street1 = ISNULL(@PhysicalAddress1,'')
			,Street2 = ISNULL(@PhysicalAddress2,'')
			,Street3 = ISNULL(@PhysicalAddress3,'')
			,City = ISNULL(@PhysicalCity,'')
			,[State] = ISNULL(@PhysicalState,'')
			,Zip = ISNULL(@PhysicalZip,'')
			,ZipPlus4 = ISNULL(@PhysicalZipPlus4,'')
		WHERE pkCPClientAddress = @PhysicalAddressID
	END
END

IF @MailingAddress1 IS NOT NULL
OR @MailingAddress2 IS NOT NULL
OR @MailingAddress3 IS NOT NULL
OR @MailingCity IS NOT NULL
OR @MailingState IS NOT NULL
OR @MailingZip IS NOT NULL
OR @MailingZipPlus4 IS NOT NULL
BEGIN
	DECLARE @MailingAddressID decimal

	SELECT @MailingAddressID = fkCPClientAddress
	FROM CPJoinClientClientAddress
	WHERE fkCPClient = @ClientID
	AND fkCPRefClientAddressType = 1

	IF @MailingAddressID IS NULL
	BEGIN
		INSERT INTO CPClientAddress
		(
			 Street1
			,Street2
			,Street3
			,City
			,[State]
			,Zip
			,ZipPlus4
			,fkCPRefClientAddressType
		)
		VALUES
		(
			 ISNULL(@MailingAddress1,'')
			,ISNULL(@MailingAddress2,'')
			,ISNULL(@MailingAddress3,'')
			,ISNULL(@MailingCity,'')
			,ISNULL(@MailingState,'')
			,ISNULL(@MailingZip,'')
			,ISNULL(@MailingZipPlus4,'')
			,1
		)
		
		SET @MailingAddressID = SCOPE_IDENTITY()

		INSERT INTO CPJoinClientClientAddress
		(
			 fkCPClient
			,fkCPClientAddress
			,fkCPRefClientAddressType
		)
		VALUES
		(
			 @ClientID
			,@MailingAddressID
			,1
		)
	END
	ELSE
	BEGIN
		UPDATE CPClientAddress
		SET  Street1 = ISNULL(@MailingAddress1,'')
			,Street2 = ISNULL(@MailingAddress2,'')
			,Street3 = ISNULL(@MailingAddress3,'')
			,City = ISNULL(@MailingCity,'')
			,State = ISNULL(@MailingState,'')
			,Zip = ISNULL(@MailingZip,'')
			,ZipPlus4 = ISNULL(@MailingZipPlus4,'')
		WHERE pkCPClientAddress = @MailingAddressID
	END
END

SELECT @ClientID