CREATE PROCEDURE [dbo].[uspFormJoinQuickListFormNameAnnotationAnnotationValueAdd]
(
	  @fkQuickListFormName decimal(18,0)
	, @fkFormAnnotation decimal(18,0)
	, @AnnotationValue varchar(max)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormJoinQuickListFormNameAnnotationAnnotationValue decimal(18,0) output
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

set @pkFormJoinQuickListFormNameAnnotationAnnotationValue = null

select @pkFormJoinQuickListFormNameAnnotationAnnotationValue = pkFormJoinQuickListFormNameAnnotationAnnotationValue 
FROM	FormJoinQuickListFormNameAnnotationAnnotationValue WITH (NOLOCK) 
WHERE	fkQuickListFormName = @fkQuickListFormName 
AND		fkFormAnnotation = @fkFormAnnotation

if @pkFormJoinQuickListFormNameAnnotationAnnotationValue is not null
	begin
	update FormJoinQuickListFormNameAnnotationAnnotationValue
	set		AnnotationValue = @AnnotationValue
	where	pkFormJoinQuickListFormNameAnnotationAnnotationValue = @pkFormJoinQuickListFormNameAnnotationAnnotationValue
	end
else
	begin
	INSERT FormJoinQuickListFormNameAnnotationAnnotationValue
		(
			fkQuickListFormName
			, fkFormAnnotation
			, AnnotationValue
		)
	VALUES
		(
			@fkQuickListFormName
			, @fkFormAnnotation
			, @AnnotationValue
		)

	set @pkFormJoinQuickListFormNameAnnotationAnnotationValue = scope_identity()
	end