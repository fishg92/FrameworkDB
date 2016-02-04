----------------------------------------------------------------------------
-- Update a single record in BackfileImport
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspBackfileImportUpdate]
(	  @pkBackfileImport decimal(18, 0)
	, @SourceFilename varchar(500) = NULL
	, @DestinationFilename varchar(500) = NULL
	, @SourceID smallint = NULL
	, @BOXID varchar(100) = NULL
	, @Docket varchar(100) = NULL
	, @CaseUPI varchar(20) = NULL
	, @CaseSuffix char(1) = NULL
	, @SSN varchar(9) = NULL
	, @Category varchar(50) = NULL
	, @DocumentType varchar(100) = NULL
	, @DocumentDate datetime = NULL
	, @NorthwoodsNumber varchar(50) = NULL
	, @Message varchar(255) = NULL
	, @Success bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	BackfileImport
SET	SourceFilename = ISNULL(@SourceFilename, SourceFilename),
	DestinationFilename = ISNULL(@DestinationFilename, DestinationFilename),
	SourceID = ISNULL(@SourceID, SourceID),
	BOXID = ISNULL(@BOXID, BOXID),
	Docket = ISNULL(@Docket, Docket),
	CaseUPI = ISNULL(@CaseUPI, CaseUPI),
	CaseSuffix = ISNULL(@CaseSuffix, CaseSuffix),
	SSN = ISNULL(@SSN, SSN),
	Category = ISNULL(@Category, Category),
	DocumentType = ISNULL(@DocumentType, DocumentType),
	DocumentDate = ISNULL(@DocumentDate, DocumentDate),
	NorthwoodsNumber = ISNULL(@NorthwoodsNumber, NorthwoodsNumber),
	Message = ISNULL(@Message, Message),
	Success = ISNULL(@Success, Success)
WHERE 	pkBackfileImport = @pkBackfileImport
