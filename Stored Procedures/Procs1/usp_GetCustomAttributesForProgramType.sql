

CREATE PROC [dbo].[usp_GetCustomAttributesForProgramType]
(	@pkProgramType decimal (18,0) 
)
AS

SELECT	pkProgramTypeClientCustomAttributeColumnMapping,
	fkProgramType,
	ClientCustomAttributeColumn,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate
FROM	ProgramTypeClientCustomAttributeColumnMapping (nolock)
WHERE 	@pkProgramType = fkProgramType
 



