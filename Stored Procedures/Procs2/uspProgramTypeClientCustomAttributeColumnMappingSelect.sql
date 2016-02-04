----------------------------------------------------------------------------
-- Select a single record from ProgramTypeClientCustomAttributeColumnMapping
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspProgramTypeClientCustomAttributeColumnMappingSelect]
(	@pkProgramTypeClientCustomAttributeColumnMapping decimal(18, 0) = NULL,
	@fkProgramType decimal(18, 0) = NULL,
	@ClientCustomAttributeColumn varchar(200) = NULL
)
AS

SELECT	pkProgramTypeClientCustomAttributeColumnMapping,
	fkProgramType,
	ClientCustomAttributeColumn
FROM	ProgramTypeClientCustomAttributeColumnMapping
WHERE 	(@pkProgramTypeClientCustomAttributeColumnMapping IS NULL OR pkProgramTypeClientCustomAttributeColumnMapping = @pkProgramTypeClientCustomAttributeColumnMapping)
 AND 	(@fkProgramType IS NULL OR fkProgramType = @fkProgramType)
 AND 	(@ClientCustomAttributeColumn IS NULL OR ClientCustomAttributeColumn LIKE @ClientCustomAttributeColumn + '%')
 

