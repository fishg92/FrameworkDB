
----------------------------------------------------------------------------
-- Delete all records from FormQuickListAdditionalStamp for a single SignatureArea Annotation
----------------------------------------------------------------------------
CREATE PROC [dbo].[DeleteFormQuickListAdditionalStampForSignatureArea]
(	@fkFormQuickListFormName decimal(18, 0)
	, @AdditionalData varchar(max)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(50)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	FormQuickListAdditionalStamp
WHERE 	fkFormQuickListFormName = @fkFormQuickListFormName
and		AdditionalData = @AdditionalData
