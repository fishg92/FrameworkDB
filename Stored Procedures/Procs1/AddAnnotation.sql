



/****** Object:  Stored Procedure dbo.AddAnnotation    Script Date: 8/21/2006 8:02:14 AM ******/



CREATE  procedure [dbo].[AddAnnotation]
(	@fkForm decimal(18,0),
	@AnnotationName varchar(100),
	@AnnotationFormOrder int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
,	@pkAnnotation decimal(18,0) output
)
as

	exec dbo.SetAuditDataContext @LupUser, @LupMachine

	Insert into dbo.Annotation
	(	fkForm,
		AnnotationName,
		AnnotationFormOrder,
		Deleted)
	values
	(	@fkForm,
		@AnnotationName,
		@AnnotationFormOrder,
		0)
	
	Set @pkAnnotation = Scope_Identity()
