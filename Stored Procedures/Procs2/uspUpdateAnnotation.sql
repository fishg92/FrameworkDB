-- Stored Procedure

CREATE proc [dbo].[uspUpdateAnnotation]
(	@pkAnnotation decimal(10, 0),
	@AnnotationName varchar(100) = null,
	@AnnotationFormOrder int = null
, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15))
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	Update 	Annotation
	Set 	AnnotationName = IsNull(@AnnotationName, AnnotationName),
		AnnotationFormOrder = IsNull(@AnnotationFormOrder, AnnotationFormOrder)
	Where	pkAnnotation  = @pkAnnotation
