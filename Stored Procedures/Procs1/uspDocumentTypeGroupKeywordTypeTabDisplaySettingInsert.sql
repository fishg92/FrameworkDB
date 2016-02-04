-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into DocumentTypeGroupKeywordTypeTabDisplaySetting
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspDocumentTypeGroupKeywordTypeTabDisplaySettingInsert]
(	  @fkDocumentTypeGroup decimal(18, 0) = NULL
	, @fkKeywordType varchar(50)
	, @Sequence int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkDocumentTypeGroupKeywordTypeTabDisplaySetting decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT DocumentTypeGroupKeywordTypeTabDisplaySetting
(	  fkDocumentTypeGroup
	, fkKeywordType
	, Sequence
)
VALUES 
(	  @fkDocumentTypeGroup
	, @fkKeywordType
	, @Sequence

)

SET @pkDocumentTypeGroupKeywordTypeTabDisplaySetting = SCOPE_IDENTITY()
