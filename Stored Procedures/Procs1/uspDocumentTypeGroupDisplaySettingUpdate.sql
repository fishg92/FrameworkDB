-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in DocumentTypeGroupDisplaySetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspDocumentTypeGroupDisplaySettingUpdate]
(	  @pkDocumentTypeGroupDisplaySetting decimal(18, 0)
	, @fkDocumentTypeGroup varchar(50) = NULL
	, @DisplayColor int = NULL
	, @Sequence int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	DocumentTypeGroupDisplaySetting
SET	fkDocumentTypeGroup = ISNULL(@fkDocumentTypeGroup, fkDocumentTypeGroup),
	DisplayColor = ISNULL(@DisplayColor, DisplayColor),
	Sequence = ISNULL(@Sequence, Sequence)
WHERE 	pkDocumentTypeGroupDisplaySetting = @pkDocumentTypeGroupDisplaySetting
