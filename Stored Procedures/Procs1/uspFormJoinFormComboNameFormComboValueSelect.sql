
----------------------------------------------------------------------------
-- Select a single record from FormJoinFormComboNameFormComboValue
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormJoinFormComboNameFormComboValueSelect]
(	@pkFormJoinFormComboNameFormComboValue decimal(10, 0) = NULL,
	@fkFormComboName decimal(10, 0) = NULL,
	@fkFormComboValue decimal(10, 0) = NULL
)
AS

SELECT	pkFormJoinFormComboNameFormComboValue,
	fkFormComboName,
	fkFormComboValue
FROM	FormJoinFormComboNameFormComboValue
WHERE 	(@pkFormJoinFormComboNameFormComboValue IS NULL OR pkFormJoinFormComboNameFormComboValue = @pkFormJoinFormComboNameFormComboValue)
 AND 	(@fkFormComboName IS NULL OR fkFormComboName = @fkFormComboName)
 AND 	(@fkFormComboValue IS NULL OR fkFormComboValue = @fkFormComboValue)



