----------------------------------------------------------------------------
-- Select a single record from ApplicationUser
----------------------------------------------------------------------------
CREATE PROC uspApplicationUserSelect
(	@pkApplicationUser decimal(18, 0) = NULL,
	@UserName varchar(50) = NULL,
	@FirstName varchar(50) = NULL,
	@LastName varchar(50) = NULL,
	@Password varchar(100) = NULL,
	@fkDepartment decimal(18, 0) = NULL,
	@LUPUser varchar(50) = NULL,
	@LUPDate datetime = NULL,
	@CreateUser varchar(50) = NULL,
	@CreateDate datetime = NULL,
	@WorkerNumber varchar(50) = NULL,
	@LDAPUser bit = NULL,
	@LDAPUniqueID varchar(100) = NULL,
	@CountyCode varchar(50) = NULL,
	@MiddleName varchar(50) = NULL,
	@eMail varchar(50) = NULL,
	@IsCaseworker bit = NULL,
	@IsActive bit = NULL,
	@eCAFFirstName varchar(50) = NULL,
	@eCAFLastName varchar(50) = NULL,
	@StateID varchar(50) = NULL,
	@PhoneNumber varchar(10) = NULL,
	@Extension varchar(10) = NULL,
	@ExternalIDNumber nvarchar(300) = NULL
)
AS

SELECT	pkApplicationUser,
	UserName,
	FirstName,
	LastName,
	Password,
	fkDepartment,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate,
	WorkerNumber,
	LDAPUser,
	LDAPUniqueID,
	CountyCode,
	MiddleName,
	eMail,
	IsCaseworker,
	IsActive,
	eCAFFirstName,
	eCAFLastName,
	StateID,
	PhoneNumber,
	Extension,
	ExternalIDNumber
FROM	ApplicationUser
WHERE 	(@pkApplicationUser IS NULL OR pkApplicationUser = @pkApplicationUser)
 AND 	(@UserName IS NULL OR UserName LIKE @UserName + '%')
 AND 	(@FirstName IS NULL OR FirstName LIKE @FirstName + '%')
 AND 	(@LastName IS NULL OR LastName LIKE @LastName + '%')
 AND 	(@Password IS NULL OR Password LIKE @Password + '%')
 AND 	(@fkDepartment IS NULL OR fkDepartment = @fkDepartment)
 AND 	(@LUPUser IS NULL OR LUPUser LIKE @LUPUser + '%')
 AND 	(@LUPDate IS NULL OR LUPDate = @LUPDate)
 AND 	(@CreateUser IS NULL OR CreateUser LIKE @CreateUser + '%')
 AND 	(@CreateDate IS NULL OR CreateDate = @CreateDate)
 AND 	(@WorkerNumber IS NULL OR WorkerNumber LIKE @WorkerNumber + '%')
 AND 	(@LDAPUser IS NULL OR LDAPUser = @LDAPUser)
 AND 	(@LDAPUniqueID IS NULL OR LDAPUniqueID LIKE @LDAPUniqueID + '%')
 AND 	(@CountyCode IS NULL OR CountyCode LIKE @CountyCode + '%')
 AND 	(@MiddleName IS NULL OR MiddleName LIKE @MiddleName + '%')
 AND 	(@eMail IS NULL OR eMail LIKE @eMail + '%')
 AND 	(@IsCaseworker IS NULL OR IsCaseworker = @IsCaseworker)
 AND 	(@IsActive IS NULL OR IsActive = @IsActive)
 AND 	(@eCAFFirstName IS NULL OR eCAFFirstName LIKE @eCAFFirstName + '%')
 AND 	(@eCAFLastName IS NULL OR eCAFLastName LIKE @eCAFLastName + '%')
 AND 	(@StateID IS NULL OR StateID LIKE @StateID + '%')
 AND 	(@PhoneNumber IS NULL OR PhoneNumber LIKE @PhoneNumber + '%')
 AND 	(@Extension IS NULL OR Extension LIKE @Extension + '%')
 AND 	(@ExternalIDNumber IS NULL OR ExternalIDNumber LIKE @ExternalIDNumber + '%')

