-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in DocumentTypeGroupKeywordTypeTabDisplaySetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspDocumentTypeGroupKeywordTypeTabDisplaySettingUpdate]
(	  @pkDocumentTypeGroupKeywordTypeTabDisplaySetting decimal(18, 0)
	, @fkDocumentTypeGroup decimal(18, 0) = NULL
	, @fkKeywordType varchar(50) = NULL
	, @Sequence int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	DocumentTypeGroupKeywordTypeTabDisplaySetting
SET	fkDocumentTypeGroup = ISNULL(@fkDocumentTypeGroup, fkDocumentTypeGroup),
	fkKeywordType = ISNULL(@fkKeywordType, fkKeywordType),
	Sequence = ISNULL(@Sequence, Sequence)
WHERE 	pkDocumentTypeGroupKeywordTypeTabDisplaySetting = @pkDocumentTypeGroupKeywordTypeTabDisplaySetting
