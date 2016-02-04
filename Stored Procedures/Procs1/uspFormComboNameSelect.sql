
----------------------------------------------------------------------------
-- Select a single record from FormComboName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormComboNameSelect]
(	@pkFormComboName decimal(10, 0) = NULL,
	@ComboName varchar(50) = NULL
)
AS

SELECT	pkFormComboName,
	ComboName
FROM	FormComboName
WHERE 	(@pkFormComboName IS NULL OR pkFormComboName = @pkFormComboName)
 AND 	(@ComboName IS NULL OR ComboName LIKE @ComboName + '%')


