


CREATE PROCEDURE [dbo].[spPSPUpdatePSPDocTypeSplit]
(
	  @pkPSPDocTypeSplit decimal(18,0)
	, @SubmitToDMS bit = NULL
	, @CopyToFolder bit = NULL
	, @fkKeywordForFolderName decimal(18,0) = NULL
	, @StaticFolderName varchar(100) = NULL
	, @CreateDocumentWhenKeywordChanges decimal(18,0) = NULL
	, @CreateDocumentEveryXPages int = NULL
	, @CreateXDocuments int = NULL
	, @Enabled bit = NULL
)
AS

	UPDATE PSPDocTypeSplit SET
	  SubmitToDMS = ISNULL(@SubmitToDMS, SubmitToDMS)
	, CopyToFolder = ISNULL(@CopyToFolder, CopyToFolder)
	, fkKeywordForFolderName = ISNULL(@fkKeywordForFolderName, fkKeywordForFolderName)
	, StaticFolderName = ISNULL(@StaticFolderName, StaticFolderName)
	, CreateDocumentWhenKeywordChanges = ISNULL(@CreateDocumentWhenKeywordChanges, CreateDocumentWhenKeywordChanges)
	, CreateDocumentEveryXPages = ISNULL(@CreateDocumentEveryXPages, CreateDocumentEveryXPages)
	, CreateXDocuments = ISNULL(@CreateXDocuments, CreateXDocuments)
	, Enabled = ISNULL(@Enabled, Enabled)
	WHERE pkPSPDocTypeSplit = @pkPSPDocTypeSplit





