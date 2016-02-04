----------------------------------------------------------------------------
-- Update a single record in DocumentTypeCaseTagging
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspDocumentTypeCaseTaggingUpdate]
(	  @pkDocumentTypeCaseTagging decimal(18, 0)
	, @fkDocumentType varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	DocumentTypeCaseTagging
SET	fkDocumentType = ISNULL(@fkDocumentType, fkDocumentType)
WHERE 	pkDocumentTypeCaseTagging = @pkDocumentTypeCaseTagging
