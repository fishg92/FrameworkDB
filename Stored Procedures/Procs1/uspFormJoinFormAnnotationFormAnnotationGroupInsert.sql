-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormJoinFormAnnotationFormAnnotationGroup
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormJoinFormAnnotationFormAnnotationGroupInsert]
(	  @fkFormAnnotation decimal(18, 0)
	, @fkFormAnnotationGroup decimal(18, 0)
	, @fkForm decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormJoinFormAnnotationFormAnnotationGroup decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormJoinFormAnnotationFormAnnotationGroup
(	  fkFormAnnotation
	, fkFormAnnotationGroup
	, fkForm
)
VALUES 
(	  @fkFormAnnotation
	, @fkFormAnnotationGroup
	, @fkForm

)

SET @pkFormJoinFormAnnotationFormAnnotationGroup = SCOPE_IDENTITY()
