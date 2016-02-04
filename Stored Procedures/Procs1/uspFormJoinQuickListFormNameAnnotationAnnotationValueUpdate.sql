-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormJoinQuickListFormNameAnnotationAnnotationValue
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormJoinQuickListFormNameAnnotationAnnotationValueUpdate]
(	  @pkFormJoinQuickListFormNameAnnotationAnnotationValue decimal(18, 0)
	, @fkQuickListFormName decimal(18, 0) = NULL
	, @fkFormAnnotation decimal(18, 0) = NULL
	, @fkAnnotationValueSmall decimal(10, 0) = NULL
	, @fkAnnotationValueMedium decimal(10, 0) = NULL
	, @fkAnnotationValueLarge decimal(10, 0) = NULL
	, @fkAnnotationValueHuge decimal(10, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormJoinQuickListFormNameAnnotationAnnotationValue
SET	fkQuickListFormName = ISNULL(@fkQuickListFormName, fkQuickListFormName),
	fkFormAnnotation = ISNULL(@fkFormAnnotation, fkFormAnnotation),
	fkAnnotationValueSmall = ISNULL(@fkAnnotationValueSmall, fkAnnotationValueSmall),
	fkAnnotationValueMedium = ISNULL(@fkAnnotationValueMedium, fkAnnotationValueMedium),
	fkAnnotationValueLarge = ISNULL(@fkAnnotationValueLarge, fkAnnotationValueLarge),
	fkAnnotationValueHuge = ISNULL(@fkAnnotationValueHuge, fkAnnotationValueHuge)
WHERE 	pkFormJoinQuickListFormNameAnnotationAnnotationValue = @pkFormJoinQuickListFormNameAnnotationAnnotationValue
