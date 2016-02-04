


CREATE PROCEDURE [dbo].[spPSPInsertPSPDocTypeSplit]
(
	  @fkPSPDocType decimal(18,0)
	, @SubmitToDMS bit
	, @CopyToFolder bit
	, @fkKeywordForFolderName decimal(18,0)
	, @StaticFolderName varchar(100)
	, @CreateDocumentWhenKeywordChanges decimal(18,0)
	, @CreateDocumentEveryXPages int
	, @CreateXDocuments int
	, @Enabled bit
	, @pkPSPDocTypeSplit decimal(18,0) OUTPUT
)
AS

	INSERT INTO PSPDocTypeSplit
	(
		  fkPSPDocType
		, SubmitToDMS
		, CopyToFolder
		, fkKeywordForFolderName
		, StaticFolderName
		, CreateDocumentWhenKeywordChanges
		, CreateDocumentEveryXPages
		, CreateXDocuments
		, Enabled
	)
	VALUES
	(
		  @fkPSPDocType
		, @SubmitToDMS
		, @CopyToFolder
		, @fkKeywordForFolderName
		, @StaticFolderName
		, @CreateDocumentWhenKeywordChanges
		, @CreateDocumentEveryXPages
		, @CreateXDocuments
		, @Enabled
	)

	SET @pkPSPDocTypeSplit = SCOPE_IDENTITY()


