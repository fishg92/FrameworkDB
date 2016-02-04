CREATE PROCEDURE [api].[SaveUser]
	 @ApplicationUserID AS DECIMAL = NULL
	,@Username AS VARCHAR(50)
	,@FirstName AS VARCHAR(50)
	,@LastName AS VARCHAR(50)
	,@Password AS VARCHAR(50)
	,@DepartmentID AS DECIMAL = NULL
	,@WorkerNumber AS VARCHAR(50)
	,@LDAPUser AS BIT = NULL
	,@LDAPUniqueID AS VARCHAR(100) = NULL
	,@CountyCode AS VARCHAR(50) = NULL
	,@MiddleName AS VARCHAR(50) = NULL
	,@eMail AS VARCHAR(50) = NULL
	,@IsCaseworker AS BIT = NULL
	,@IsActive AS BIT = NULL
	,@StateID AS VARCHAR(50) = NULL
	,@PhoneNumber AS VARCHAR(10) = NULL
	,@Extension AS VARCHAR(10) = NULL
	,@ExternalIDNumber AS NVARCHAR(150) = NULL
	,@LUPUser varchar(50) = '0'
AS 

EXEC dbo.SetAuditDataContext @AuditUser = @LUPUser, @AuditMachine = 'WebAPI'

IF  @ApplicationUserID IS NULL
AND @ExternalIDNumber IS NOT NULL
BEGIN
	SELECT @ApplicationUserID = pkApplicationUser
	FROM ApplicationUser
	WHERE ExternalIDNumber = @ExternalIDNumber
END

IF @ApplicationUserID IS NULL
BEGIN
	SELECT @ApplicationUserID = pkApplicationUser
	FROM ApplicationUser
	WHERE UserName = @Username
END

IF @ApplicationUserID IS NULL
BEGIN
	INSERT INTO [dbo].[ApplicationUser]
    (
		 [UserName]
        ,[FirstName]
        ,[LastName]
        ,[Password]
        ,[fkDepartment]
        ,[WorkerNumber]
        ,[CountyCode]
		,LDAPUser
		,LDAPUniqueID
        ,[MiddleName]
        ,[eMail]
        ,[IsCaseworker]
        ,[IsActive]
        ,[StateID]
        ,[PhoneNumber]
        ,[Extension]
        ,[ExternalIDNumber]
	)
    VALUES
    (
		 @Username
		,@FirstName
		,@LastName
		,@Password
		,@DepartmentID
		,@WorkerNumber
		,@LDAPUser
		,@LDAPUniqueID
		,@CountyCode
		,@MiddleName
		,@eMail
		,@IsCaseworker
		,@IsActive
		,@StateID
		,@PhoneNumber
		,@Extension
		,@ExternalIDNumber
	)
	SET @ApplicationUserID = SCOPE_IDENTITY()
END
ELSE
BEGIN
	UPDATE [dbo].[ApplicationUser]
	SET [UserName] = @UserName
		  ,[FirstName] = @FirstName
		  ,[LastName] = @LastName
		  ,[Password] = @Password
		  ,[fkDepartment] = @DepartmentID
		  ,[WorkerNumber] = @WorkerNumber
		  ,[LDAPUser] = @LDAPUser
		  ,[LDAPUniqueID] = @LDAPUniqueID
		  ,[CountyCode] = @CountyCode
		  ,[MiddleName] = @MiddleName
		  ,[eMail] = @eMail
		  ,[IsCaseworker] = @IsCaseworker
		  ,[IsActive] = @IsActive
		  ,[StateID] = @StateID
		  ,[PhoneNumber] = @PhoneNumber
		  ,[Extension] = @Extension
		  ,[ExternalIDNumber] = @ExternalIDNumber
	WHERE pkApplicationUser = @ApplicationUserID
END

SELECT * 
FROM ApplicationUser 
WHERE pkApplicationUser = @ApplicationUserID