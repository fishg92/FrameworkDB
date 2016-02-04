


/****** Object:  Stored Procedure dbo.UPDATEANNOTATION    Script Date: 8/21/2006 8:02:14 AM ******/


CREATE proc [dbo].[UPDATEANNOTATION]
(	@pkAnnotation decimal(18, 0),
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
