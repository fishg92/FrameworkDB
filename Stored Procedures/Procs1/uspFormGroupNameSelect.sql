
----------------------------------------------------------------------------
-- Select a single record from FormGroupName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormGroupNameSelect]
(	@pkFormGroupName decimal(10, 0) = NULL,
	@Name varchar(255) = NULL
)
AS

SELECT	pkFormGroupName,
	Name
FROM	FormGroupName
WHERE 	(@pkFormGroupName IS NULL OR pkFormGroupName = @pkFormGroupName)
 AND 	(@Name IS NULL OR Name LIKE @Name + '%')

