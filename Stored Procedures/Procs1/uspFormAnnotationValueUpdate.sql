-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormAnnotationValue
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormAnnotationValueUpdate]
(	  @pkFormAnnotationValue decimal(10, 0)
	, @fkFormRendition decimal(10, 0) = NULL
	, @fkFormAnnotation decimal(10, 0) = NULL
	, @fkFormAnnotationValueSmall decimal(10, 0) = NULL
	, @fkFormAnnotationValueMedium decimal(10, 0) = NULL
	, @fkFormAnnotationValueLarge decimal(10, 0) = NULL
	, @fkFormAnnotationValueHuge decimal(10, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormAnnotationValue
SET	fkFormRendition = ISNULL(@fkFormRendition, fkFormRendition),
	fkFormAnnotation = ISNULL(@fkFormAnnotation, fkFormAnnotation),
	fkFormAnnotationValueSmall = ISNULL(@fkFormAnnotationValueSmall, fkFormAnnotationValueSmall),
	fkFormAnnotationValueMedium = ISNULL(@fkFormAnnotationValueMedium, fkFormAnnotationValueMedium),
	fkFormAnnotationValueLarge = ISNULL(@fkFormAnnotationValueLarge, fkFormAnnotationValueLarge),
	fkFormAnnotationValueHuge = ISNULL(@fkFormAnnotationValueHuge, fkFormAnnotationValueHuge)
WHERE 	pkFormAnnotationValue = @pkFormAnnotationValue
