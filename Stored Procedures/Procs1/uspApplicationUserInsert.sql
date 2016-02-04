----------------------------------------------------------------------------
-- Insert a single record into ApplicationUser
----------------------------------------------------------------------------
CREATE PROC uspApplicationUserInsert
(	  @UserName varchar(50)
	, @FirstName varchar(50)
	, @LastName varchar(50)
	, @Password varchar(100)
	, @fkDepartment decimal(18, 0) = NULL
	, @WorkerNumber varchar(50) = NULL
	, @LDAPUser bit = NULL
	, @LDAPUniqueID varchar(100) = NULL
	, @CountyCode varchar(50) = NULL
	, @MiddleName varchar(50) = NULL
	, @eMail varchar(50) = NULL
	, @IsCaseworker bit = NULL
	, @IsActive bit = NULL
	, @eCAFFirstName varchar(50) = NULL
	, @eCAFLastName varchar(50) = NULL
	, @StateID varchar(50) = NULL
	, @PhoneNumber varchar(10) = NULL
	, @Extension varchar(10) = NULL
	, @ExternalIDNumber nvarchar(300) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkApplicationUser decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine


INSERT ApplicationUser
(	  UserName
	, FirstName
	, LastName
	, Password
	, fkDepartment
	, WorkerNumber
	, LDAPUser
	, LDAPUniqueID
	, CountyCode
	, MiddleName
	, eMail
	, IsCaseworker
	, IsActive
	, eCAFFirstName
	, eCAFLastName
	, StateID
	, PhoneNumber
	, Extension
	, ExternalIDNumber
)
VALUES 
(	  @UserName
	, @FirstName
	, @LastName
	, @Password
	, @fkDepartment
	, @WorkerNumber
	, @LDAPUser
	, @LDAPUniqueID
	, COALESCE(@CountyCode, '')
	, @MiddleName
	, @eMail
	, COALESCE(@IsCaseworker, (1))
	, @IsActive
	, @eCAFFirstName
	, @eCAFLastName
	, @StateID
	, @PhoneNumber
	, @Extension
	, @ExternalIDNumber

)

SET @pkApplicationUser = SCOPE_IDENTITY()
