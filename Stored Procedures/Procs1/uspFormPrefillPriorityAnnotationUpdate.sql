----------------------------------------------------------------------------
-- Update a single record in FormPrefillPriorityAnnotation
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormPrefillPriorityAnnotationUpdate]
(	  @pkFormPrefillPriorityAnnotation decimal(18, 0)
	, @KeywordName varchar(200) = NULL
	, @Position int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormPrefillPriorityAnnotation
SET	KeywordName = ISNULL(@KeywordName, KeywordName),
	Position = ISNULL(@Position, Position)
WHERE 	pkFormPrefillPriorityAnnotation = @pkFormPrefillPriorityAnnotation
