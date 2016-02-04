----------------------------------------------------------------------------
-- Select a single record from FormAnnotationGroup
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormAnnotationGroupSelect]
(	@pkFormAnnotationGroup decimal(18, 0) = NULL,
	@Name varchar(50) = NULL,
	@Description varchar(250) = NULL,
	@Type int = NULL,
	@fkAutofillDataSource decimal(18,0) = NULL,
	@UseAutofillForIndexing bit = NULL
)
AS

SELECT	pkFormAnnotationGroup,
	Name,
	[Description],
	[Type]
FROM	FormAnnotationGroup
WHERE 	(@pkFormAnnotationGroup IS NULL OR pkFormAnnotationGroup = @pkFormAnnotationGroup)
 AND 	(@Name IS NULL OR Name LIKE @Name + '%')
 AND 	(@Description IS NULL OR [Description] LIKE @Description + '%')
 AND 	(@Type IS NULL OR [Type] = @Type)
 AND	(@fkAutofillDataSource IS NULL OR fkAutofillDataSource = @fkAutofillDataSource)
 AND	(@UseAutofillForIndexing IS NULL OR UseAutofillForIndexing = @UseAutofillForIndexing)
