
----------------------------------------------------------------------------
-- Select a single record from FormComboValue
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormComboValueSelect]
(	@pkFormComboValue decimal(10, 0) = NULL,
	@ComboValue varchar(255) = NULL
)
AS

SELECT	pkFormComboValue,
	ComboValue
FROM	FormComboValue
WHERE 	(@pkFormComboValue IS NULL OR pkFormComboValue = @pkFormComboValue)
 AND 	(@ComboValue IS NULL OR ComboValue LIKE @ComboValue + '%')



