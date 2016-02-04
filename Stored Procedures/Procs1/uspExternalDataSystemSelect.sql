----------------------------------------------------------------------------
-- Select a single record from ExternalDataSystem
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspExternalDataSystemSelect]
(	@pkExternalDataSystem decimal(18, 0) = NULL,
	@Name varchar(255) = NULL
)
AS

SELECT	pkExternalDataSystem,
	Name
FROM	ExternalDataSystem
WHERE 	(@pkExternalDataSystem IS NULL OR pkExternalDataSystem = @pkExternalDataSystem)
 AND 	(@Name IS NULL OR Name LIKE @Name + '%')
