----------------------------------------------------------------------------
-- Update a single record in PSPDocTypeSplit
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPDocTypeSplitUpdate]
(	  @pkPSPDocTypeSplit decimal(18, 0)
	, @fkPSPDocType decimal(18, 0) = NULL
	, @SubmitToDMS bit = NULL
	, @CopyToFolder bit = NULL
	, @fkKeywordForFolderName decimal(18, 0) = NULL
	, @StaticFolderName varchar(100) = NULL
	, @CreateDocumentWhenKeywordChanges decimal(18, 0) = NULL
	, @CreateDocumentEveryXPages int = NULL
	, @CreateXDocuments int = NULL
	, @Enabled bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	PSPDocTypeSplit
SET	fkPSPDocType = ISNULL(@fkPSPDocType, fkPSPDocType),
	SubmitToDMS = ISNULL(@SubmitToDMS, SubmitToDMS),
	CopyToFolder = ISNULL(@CopyToFolder, CopyToFolder),
	fkKeywordForFolderName = ISNULL(@fkKeywordForFolderName, fkKeywordForFolderName),
	StaticFolderName = ISNULL(@StaticFolderName, StaticFolderName),
	CreateDocumentWhenKeywordChanges = ISNULL(@CreateDocumentWhenKeywordChanges, CreateDocumentWhenKeywordChanges),
	CreateDocumentEveryXPages = ISNULL(@CreateDocumentEveryXPages, CreateDocumentEveryXPages),
	CreateXDocuments = ISNULL(@CreateXDocuments, CreateXDocuments),
	Enabled = ISNULL(@Enabled, Enabled)
WHERE 	pkPSPDocTypeSplit = @pkPSPDocTypeSplit
