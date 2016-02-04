-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from DocumentTypeGroupKeywordTypeTabDisplaySetting
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspDocumentTypeGroupKeywordTypeTabDisplaySettingDelete]
(	@pkDocumentTypeGroupKeywordTypeTabDisplaySetting int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	DocumentTypeGroupKeywordTypeTabDisplaySetting
WHERE 	pkDocumentTypeGroupKeywordTypeTabDisplaySetting = @pkDocumentTypeGroupKeywordTypeTabDisplaySetting
