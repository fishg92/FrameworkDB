----------------------------------------------------------------------------
-- Update a single record in ApplicationUser
----------------------------------------------------------------------------
CREATE PROC uspApplicationUserUpdate
(	  @pkApplicationUser decimal(18, 0)
	, @UserName varchar(50) = NULL
	, @FirstName varchar(50) = NULL
	, @LastName varchar(50) = NULL
	, @Password varchar(100) = NULL
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
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine


UPDATE	ApplicationUser
SET	UserName = ISNULL(@UserName, UserName),
	FirstName = ISNULL(@FirstName, FirstName),
	LastName = ISNULL(@LastName, LastName),
	Password = ISNULL(@Password, Password),
	fkDepartment = ISNULL(@fkDepartment, fkDepartment),
	WorkerNumber = ISNULL(@WorkerNumber, WorkerNumber),
	LDAPUser = ISNULL(@LDAPUser, LDAPUser),
	LDAPUniqueID = ISNULL(@LDAPUniqueID, LDAPUniqueID),
	CountyCode = ISNULL(@CountyCode, CountyCode),
	MiddleName = ISNULL(@MiddleName, MiddleName),
	eMail = ISNULL(@eMail, eMail),
	IsCaseworker = ISNULL(@IsCaseworker, IsCaseworker),
	IsActive = ISNULL(@IsActive, IsActive),
	eCAFFirstName = ISNULL(@eCAFFirstName, eCAFFirstName),
	eCAFLastName = ISNULL(@eCAFLastName, eCAFLastName),
	StateID = ISNULL(@StateID, StateID),
	PhoneNumber = ISNULL(@PhoneNumber, PhoneNumber),
	Extension = ISNULL(@Extension, Extension),
	ExternalIDNumber = ISNULL(@ExternalIDNumber, ExternalIDNumber)
WHERE 	pkApplicationUser = @pkApplicationUser
