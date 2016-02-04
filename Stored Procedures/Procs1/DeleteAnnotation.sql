


/****** Object:  Stored Procedure dbo.DeleteAnnotation    Script Date: 8/21/2006 8:02:14 AM ******/


CREATE PROCEDURE [dbo].[DeleteAnnotation]
(	@pkAnnotation decimal(18,0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	Update 	Annotation
	Set	Deleted = 1
	Where	pkAnnotation = @pkAnnotation
