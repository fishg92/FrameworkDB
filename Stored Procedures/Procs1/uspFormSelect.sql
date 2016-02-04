
----------------------------------------------------------------------------
-- Select a single record from Form
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormSelect]
(	@pkForm decimal(10, 0) = NULL,
	@FormName varchar(500) = NULL
)
AS

SELECT	pkForm,
	FormName
FROM	Form
WHERE 	(@pkForm IS NULL OR pkForm = @pkForm)
 AND 	(@FormName IS NULL OR FormName LIKE @FormName + '%')

