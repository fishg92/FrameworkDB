----------------------------------------------------------------------------
-- Insert a single record into PSPDocTypeSplit
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspPSPDocTypeSplitInsert]
(	  @fkPSPDocType decimal(18, 0)
	, @SubmitToDMS bit
	, @CopyToFolder bit
	, @fkKeywordForFolderName decimal(18, 0)
	, @StaticFolderName varchar(100)
	, @CreateDocumentWhenKeywordChanges decimal(18, 0)
	, @CreateDocumentEveryXPages int
	, @CreateXDocuments int
	, @Enabled bit
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkPSPDocTypeSplit decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT PSPDocTypeSplit
(	  fkPSPDocType
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
(	  @fkPSPDocType
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
