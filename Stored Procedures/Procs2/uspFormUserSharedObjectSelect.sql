----------------------------------------------------------------------------
-- Select a single record from FormUserSharedObject
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormUserSharedObjectSelect]
(	@pkFormUserSharedObject decimal(18, 0) = NULL,
	@fkFrameworkUserID decimal(18, 0) = NULL,
	@fkFormAnnotationSharedObject decimal(18, 0) = NULL,
	@Value text = NULL
)
AS

SELECT	pkFormUserSharedObject,
	fkFrameworkUserID,
	fkFormAnnotationSharedObject,
	Value
FROM	FormUserSharedObject
WHERE 	(@pkFormUserSharedObject IS NULL OR pkFormUserSharedObject = @pkFormUserSharedObject)
 AND 	(@fkFrameworkUserID IS NULL OR fkFrameworkUserID = @fkFrameworkUserID)
 AND 	(@fkFormAnnotationSharedObject IS NULL OR fkFormAnnotationSharedObject = @fkFormAnnotationSharedObject)
 