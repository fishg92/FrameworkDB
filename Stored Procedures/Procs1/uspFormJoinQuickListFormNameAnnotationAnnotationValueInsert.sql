-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormJoinQuickListFormNameAnnotationAnnotationValue
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormJoinQuickListFormNameAnnotationAnnotationValueInsert]
(	  @fkQuickListFormName decimal(18, 0)
	, @fkFormAnnotation decimal(18, 0)
	, @fkAnnotationValueSmall decimal(10, 0) = NULL
	, @fkAnnotationValueMedium decimal(10, 0) = NULL
	, @fkAnnotationValueLarge decimal(10, 0) = NULL
	, @fkAnnotationValueHuge decimal(10, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormJoinQuickListFormNameAnnotationAnnotationValue decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormJoinQuickListFormNameAnnotationAnnotationValue
(	  fkQuickListFormName
	, fkFormAnnotation
	, fkAnnotationValueSmall
	, fkAnnotationValueMedium
	, fkAnnotationValueLarge
	, fkAnnotationValueHuge
)
VALUES 
(	  @fkQuickListFormName
	, @fkFormAnnotation
	, @fkAnnotationValueSmall
	, @fkAnnotationValueMedium
	, @fkAnnotationValueLarge
	, @fkAnnotationValueHuge

)

SET @pkFormJoinQuickListFormNameAnnotationAnnotationValue = SCOPE_IDENTITY()
