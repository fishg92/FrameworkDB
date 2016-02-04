-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormAnnotationValue
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormAnnotationValueInsert]
(	  @fkFormRendition decimal(10, 0)
	, @fkFormAnnotation decimal(10, 0)
	, @fkFormAnnotationValueSmall decimal(10, 0) = NULL
	, @fkFormAnnotationValueMedium decimal(10, 0) = NULL
	, @fkFormAnnotationValueLarge decimal(10, 0) = NULL
	, @fkFormAnnotationValueHuge decimal(10, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormAnnotationValue decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormAnnotationValue
(	  fkFormRendition
	, fkFormAnnotation
	, fkFormAnnotationValueSmall
	, fkFormAnnotationValueMedium
	, fkFormAnnotationValueLarge
	, fkFormAnnotationValueHuge
)
VALUES 
(	  @fkFormRendition
	, @fkFormAnnotation
	, @fkFormAnnotationValueSmall
	, @fkFormAnnotationValueMedium
	, @fkFormAnnotationValueLarge
	, @fkFormAnnotationValueHuge

)

SET @pkFormAnnotationValue = SCOPE_IDENTITY()
