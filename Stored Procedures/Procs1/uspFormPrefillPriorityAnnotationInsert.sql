----------------------------------------------------------------------------
-- Insert a single record into FormPrefillPriorityAnnotation
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormPrefillPriorityAnnotationInsert]
(	  @KeywordName varchar(200)
	, @Position int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkFormPrefillPriorityAnnotation decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormPrefillPriorityAnnotation
(	  KeywordName
	, Position
)
VALUES 
(	  @KeywordName
	, @Position

)

SET @pkFormPrefillPriorityAnnotation = SCOPE_IDENTITY()
