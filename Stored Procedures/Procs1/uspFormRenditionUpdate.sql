-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormRendition
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormRenditionUpdate]
(	  @pkFormRendition decimal(10, 0)
	, @fkFormName decimal(10, 0) = NULL
	, @Finished tinyint = NULL
	, @CaseNumber varchar(50) = NULL
	, @SSN varchar(50) = NULL
	, @FirstName varchar(50) = NULL
	, @LastName varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormRendition
SET	fkFormName = ISNULL(@fkFormName, fkFormName),
	Finished = ISNULL(@Finished, Finished),
	CaseNumber = ISNULL(@CaseNumber, CaseNumber),
	SSN = ISNULL(@SSN, SSN),
	FirstName = ISNULL(@FirstName, FirstName),
	LastName = ISNULL(@LastName, LastName)
WHERE 	pkFormRendition = @pkFormRendition
