-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormRemoveAnnotationFromAnnotationGroup]
(
	  @pkFormAnnotation decimal(18,0)
	, @pkFormAnnotationGroup decimal(18,0)
	, @pkForm decimal(18,0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	DELETE FROM FormJoinFormAnnotationFormAnnotationGroup 
	WHERE fkFormAnnotation = @pkFormAnnotation
	AND fkFormAnnotationGroup = @pkFormAnnotationGroup
	AND fkForm = @pkForm
