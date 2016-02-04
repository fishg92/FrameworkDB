-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into DocumentTypeGroupDisplaySetting
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspDocumentTypeGroupDisplaySettingInsert]
(	  @fkDocumentTypeGroup varchar(50)
	, @DisplayColor int
	, @Sequence int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkDocumentTypeGroupDisplaySetting decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT DocumentTypeGroupDisplaySetting
(	  fkDocumentTypeGroup
	, DisplayColor
	, Sequence
)
VALUES 
(	  @fkDocumentTypeGroup
	, @DisplayColor
	, @Sequence

)

SET @pkDocumentTypeGroupDisplaySetting = SCOPE_IDENTITY()
