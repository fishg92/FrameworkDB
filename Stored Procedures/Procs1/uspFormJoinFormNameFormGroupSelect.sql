
----------------------------------------------------------------------------
-- Select a single record from FormJoinFormNameFormGroup
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormJoinFormNameFormGroupSelect]
(	@pkFormJoinFormNameFormGroup decimal(10, 0) = NULL,
	@fkFormGroup decimal(10, 0) = NULL,
	@fkFormName decimal(10, 0) = NULL,
	@fkFormJoinFormNameFormGroupParent decimal(10, 0) = NULL,
	@fkFormGroupFormCaption decimal(10, 0) = NULL,
	@Copies int = NULL,
	@FormOrder int = NULL
)
AS

SELECT	pkFormJoinFormNameFormGroup,
	fkFormGroup,
	fkFormName,
	fkFormJoinFormNameFormGroupParent,
	fkFormGroupFormCaption,
	Copies,
	FormOrder
	
FROM	FormJoinFormNameFormGroup
WHERE 	(@pkFormJoinFormNameFormGroup IS NULL OR pkFormJoinFormNameFormGroup = @pkFormJoinFormNameFormGroup)
 AND 	(@fkFormGroup IS NULL OR fkFormGroup = @fkFormGroup)
 AND 	(@fkFormName IS NULL OR fkFormName = @fkFormName)
 AND 	(@fkFormJoinFormNameFormGroupParent IS NULL OR fkFormJoinFormNameFormGroupParent = @fkFormJoinFormNameFormGroupParent)
 AND 	(@fkFormGroupFormCaption IS NULL OR fkFormGroupFormCaption = @fkFormGroupFormCaption)
 AND 	(@Copies IS NULL OR Copies = @Copies)
 AND 	(@FormOrder IS NULL OR FormOrder = @FormOrder)



