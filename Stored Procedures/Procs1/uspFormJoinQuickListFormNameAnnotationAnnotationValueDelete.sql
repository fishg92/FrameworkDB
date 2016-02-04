-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from FormJoinQuickListFormNameAnnotationAnnotationValue
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormJoinQuickListFormNameAnnotationAnnotationValueDelete]
(	@pkFormJoinQuickListFormNameAnnotationAnnotationValue decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	FormJoinQuickListFormNameAnnotationAnnotationValue
WHERE 	pkFormJoinQuickListFormNameAnnotationAnnotationValue = @pkFormJoinQuickListFormNameAnnotationAnnotationValue
