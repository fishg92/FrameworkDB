CREATE PROCEDURE [dbo].[uspFormGetFormsContainingCombo]
(
	@pkFormComboName decimal(18, 0)
)
AS

SELECT * FROM FormName 
WHERE pkFormName IN 
(
	SELECT fkForm FROM FormAnnotation 
	WHERE fkFormComboName = @pkFormComboName AND Deleted = 0
)
AND
[Status] <> 4

