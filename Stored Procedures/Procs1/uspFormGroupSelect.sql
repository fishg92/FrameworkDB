
----------------------------------------------------------------------------
-- Select a single record from FormGroup
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormGroupSelect]
(	@pkFormGroup decimal(10, 0) = NULL,
	@fkFormGroupName decimal(10, 0) = NULL,
	@Status tinyint = NULL
)
AS

SELECT	pkFormGroup,
	fkFormGroupName,
	Status
	
FROM	FormGroup
WHERE 	(@pkFormGroup IS NULL OR pkFormGroup = @pkFormGroup)
 AND 	(@fkFormGroupName IS NULL OR fkFormGroupName = @fkFormGroupName)
 AND 	(@Status IS NULL OR Status = @Status)



