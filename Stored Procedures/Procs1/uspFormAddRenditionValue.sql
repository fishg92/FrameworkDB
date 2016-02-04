-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormAddRenditionValue]
(	
	  @fkFormRendition decimal(10,0)
	, @fkFormAnnotation decimal(10,0)
	, @AnnotationValue varchar(5000)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	IF EXISTS (SELECT * FROM FormAnnotationValue WHERE	fkFormRendition = @fkFormRendition AND fkFormAnnotation = @fkFormAnnotation)
	BEGIN

		UPDATE FormAnnotationValue
		SET AnnotationValue = @AnnotationValue
		WHERE fkFormRendition = @fkFormRendition
		AND fkFormAnnotation = @fkFormAnnotation
	END
	ELSE
	BEGIN
		INSERT INTO FormAnnotationValue
		(
			  fkFormRendition
			, fkFormAnnotation
			, AnnotationValue
		)
		VALUES
		(
			  @fkFormRendition
			, @fkFormAnnotation
			, @AnnotationValue
		)
	END
