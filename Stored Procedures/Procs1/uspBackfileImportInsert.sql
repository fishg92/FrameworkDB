----------------------------------------------------------------------------
-- Insert a single record into BackfileImport
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspBackfileImportInsert]
(	  @SourceFilename varchar(500) = NULL
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
	, @pkBackfileImport decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT BackfileImport
(	  SourceFilename
	, DestinationFilename
	, SourceID
	, BOXID
	, Docket
	, CaseUPI
	, CaseSuffix
	, SSN
	, Category
	, DocumentType
	, DocumentDate
	, NorthwoodsNumber
	, Message
	, Success
)
VALUES 
(	  @SourceFilename
	, @DestinationFilename
	, @SourceID
	, @BOXID
	, @Docket
	, @CaseUPI
	, @CaseSuffix
	, @SSN
	, @Category
	, @DocumentType
	, @DocumentDate
	, @NorthwoodsNumber
	, @Message
	, @Success

)

SET @pkBackfileImport = SCOPE_IDENTITY()
