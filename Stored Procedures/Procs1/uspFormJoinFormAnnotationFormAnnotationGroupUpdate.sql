-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormJoinFormAnnotationFormAnnotationGroup
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormJoinFormAnnotationFormAnnotationGroupUpdate]
(	  @pkFormJoinFormAnnotationFormAnnotationGroup decimal(18, 0)
	, @fkFormAnnotation decimal(18, 0) = NULL
	, @fkFormAnnotationGroup decimal(18, 0) = NULL
	, @fkForm decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormJoinFormAnnotationFormAnnotationGroup
SET	fkFormAnnotation = ISNULL(@fkFormAnnotation, fkFormAnnotation),
	fkFormAnnotationGroup = ISNULL(@fkFormAnnotationGroup, fkFormAnnotationGroup),
	fkForm = ISNULL(@fkForm, fkForm)
WHERE 	pkFormJoinFormAnnotationFormAnnotationGroup = @pkFormJoinFormAnnotationFormAnnotationGroup
