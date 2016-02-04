
-- Stored Procedure

CREATE PROCEDURE [dbo].[uspFormRemoveRenditionValue]
(
	  @fkFormRendition decimal(10,0)
	, @fkFormAnnotation decimal(10,0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

	exec dbo.SetAuditDataContext @LupUser, @LupMachine

	DELETE FROM FormAnnotationValue 
	WHERE fkFormRendition = @fkFormRendition 
	AND fkFormAnnotation = @fkFormAnnotation
