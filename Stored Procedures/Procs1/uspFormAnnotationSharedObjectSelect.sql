----------------------------------------------------------------------------
-- Select a single record from FormAnnotationSharedObject
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormAnnotationSharedObjectSelect]
(	@pkFormAnnotationSharedObject decimal(18, 0) = NULL,
	@ObjectName varchar(255) = NULL,
	@BinaryData varbinary(MAX) = NULL,
	@StringData text = NULL,
	@Active bit = NULL
)
AS

SELECT	pkFormAnnotationSharedObject,
	ObjectName,
	BinaryData,
	StringData,
	Active
FROM	FormAnnotationSharedObject
WHERE 	(@pkFormAnnotationSharedObject IS NULL OR pkFormAnnotationSharedObject = @pkFormAnnotationSharedObject)
 AND 	(@ObjectName IS NULL OR ObjectName LIKE @ObjectName + '%')
 AND 	(@Active IS NULL OR Active = @Active)
 

