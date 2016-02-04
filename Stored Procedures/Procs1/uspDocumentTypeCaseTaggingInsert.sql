----------------------------------------------------------------------------
-- Insert a single record into DocumentTypeCaseTagging
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspDocumentTypeCaseTaggingInsert]
(	  @fkDocumentType varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkDocumentTypeCaseTagging decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT DocumentTypeCaseTagging
(	  fkDocumentType
)
VALUES 
(	  @fkDocumentType

)

SET @pkDocumentTypeCaseTagging = SCOPE_IDENTITY()
