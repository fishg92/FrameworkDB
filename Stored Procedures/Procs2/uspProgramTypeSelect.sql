----------------------------------------------------------------------------
-- Select a single record from ProgramType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspProgramTypeSelect]
(	@pkProgramType decimal(18, 0) = NULL,
	@ProgramType varchar(50) = NULL,
	@ExternalName varchar(50) = NULL
)
AS

SELECT	pkProgramType,
	ProgramType,
	ExternalName
FROM	ProgramType
WHERE 	(@pkProgramType IS NULL OR pkProgramType = @pkProgramType)
 AND 	(@ProgramType IS NULL OR ProgramType LIKE @ProgramType + '%')
 AND 	(@ExternalName IS NULL OR ExternalName LIKE @ExternalName + '%')
 
 order by ProgramType

