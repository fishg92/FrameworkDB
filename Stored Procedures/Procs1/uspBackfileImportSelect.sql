----------------------------------------------------------------------------
-- Select a single record from BackfileImport
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspBackfileImportSelect]
(	@pkBackfileImport decimal(18, 0) = NULL,
	@SourceFilename varchar(500) = NULL,
	@DestinationFilename varchar(500) = NULL,
	@SourceID smallint = NULL,
	@BOXID varchar(100) = NULL,
	@Docket varchar(100) = NULL,
	@CaseUPI varchar(20) = NULL,
	@CaseSuffix char(1) = NULL,
	@SSN varchar(9) = NULL,
	@Category varchar(50) = NULL,
	@DocumentType varchar(100) = NULL,
	@DocumentDate datetime = NULL,
	@NorthwoodsNumber varchar(50) = NULL,
	@Message varchar(255) = NULL,
	@Success bit = NULL
)
AS

SELECT	pkBackfileImport,
	SourceFilename,
	DestinationFilename,
	SourceID,
	BOXID,
	Docket,
	CaseUPI,
	CaseSuffix,
	SSN,
	Category,
	DocumentType,
	DocumentDate,
	NorthwoodsNumber,
	Message,
	Success
FROM	BackfileImport
WHERE 	(@pkBackfileImport IS NULL OR pkBackfileImport = @pkBackfileImport)
 AND 	(@SourceFilename IS NULL OR SourceFilename LIKE @SourceFilename + '%')
 AND 	(@DestinationFilename IS NULL OR DestinationFilename LIKE @DestinationFilename + '%')
 AND 	(@SourceID IS NULL OR SourceID = @SourceID)
 AND 	(@BOXID IS NULL OR BOXID LIKE @BOXID + '%')
 AND 	(@Docket IS NULL OR Docket LIKE @Docket + '%')
 AND 	(@CaseUPI IS NULL OR CaseUPI LIKE @CaseUPI + '%')
 AND 	(@CaseSuffix IS NULL OR CaseSuffix LIKE @CaseSuffix + '%')
 AND 	(@SSN IS NULL OR SSN LIKE @SSN + '%')
 AND 	(@Category IS NULL OR Category LIKE @Category + '%')
 AND 	(@DocumentType IS NULL OR DocumentType LIKE @DocumentType + '%')
 AND 	(@DocumentDate IS NULL OR DocumentDate = @DocumentDate)
 AND 	(@NorthwoodsNumber IS NULL OR NorthwoodsNumber LIKE @NorthwoodsNumber + '%')
 AND 	(@Message IS NULL OR Message LIKE @Message + '%')
 AND 	(@Success IS NULL OR Success = @Success)


