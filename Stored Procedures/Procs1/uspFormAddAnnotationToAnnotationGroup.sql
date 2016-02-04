-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormAddAnnotationToAnnotationGroup]
(
	  @pkFormAnnotation decimal(18, 0)
	, @pkFormAnnotationGroup decimal(18, 0)
	, @pkFormName decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormJoinFormAnnotationFormAnnotationGroup decimal(18, 0) output
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	DECLARE @GroupType int

	SELECT @GroupType = [Type] FROM FormAnnotationGroup WHERE pkFormAnnotationGroup = @pkFormAnnotationGroup

	IF ISNULL(@GroupType,0) > 0
	BEGIN
		-- delete all join records that match this annotation to a group of the same type
		DELETE FROM FormJoinFormAnnotationFormAnnotationGroup 
		WHERE fkFormAnnotation = @pkFormAnnotation AND fkFormAnnotationGroup IN 
		(
			SELECT pkFormAnnotationGroup 
			FROM FormAnnotationGroup 
			WHERE [Type] = @GroupType AND pkFormAnnotationGroup IN 
			(
				SELECT fkFormAnnotationGroup 
				FROM FormJoinFormAnnotationFormAnnotationGroup 
				WHERE fkFormAnnotation = @pkFormAnnotation
			)
		)
	END

	INSERT INTO FormJoinFormAnnotationFormAnnotationGroup(fkFormAnnotation, fkFormAnnotationGroup, fkForm) 
	VALUES(@pkFormAnnotation, @pkFormAnnotationGroup, @pkFormName)

	SET @pkFormJoinFormAnnotationFormAnnotationGroup = SCOPE_IDENTITY()
