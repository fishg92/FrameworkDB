-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormRendition
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormRenditionInsert]
(	  @fkFormName decimal(10, 0)
	, @Finished tinyint = NULL
	, @CaseNumber varchar(50) = NULL
	, @SSN varchar(50) = NULL
	, @FirstName varchar(50) = NULL
	, @LastName varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormRendition decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormRendition
(	  fkFormName
	, Finished
	, CaseNumber
	, SSN
	, FirstName
	, LastName
)
VALUES 
(	  @fkFormName
	, @Finished
	, @CaseNumber
	, @SSN
	, @FirstName
	, @LastName

)

SET @pkFormRendition = SCOPE_IDENTITY()
