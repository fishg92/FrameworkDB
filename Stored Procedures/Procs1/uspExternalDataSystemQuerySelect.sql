----------------------------------------------------------------------------
-- Select a single record from ExternalDataSystemQuery
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspExternalDataSystemQuerySelect]
(	@pkExternalDataSystemQuery decimal(18, 0) = NULL,
	@fkApplicationUser decimal(18, 0) = NULL,
	@fkExternalDataSystem decimal(18, 0) = NULL,
	@Query varchar(MAX) = NULL
)
AS

SELECT	pkExternalDataSystemQuery,
	fkApplicationUser,
	fkExternalDataSystem,
	Query
FROM	ExternalDataSystemQuery
WHERE 	(@pkExternalDataSystemQuery IS NULL OR pkExternalDataSystemQuery = @pkExternalDataSystemQuery)
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)
 AND 	(@fkExternalDataSystem IS NULL OR fkExternalDataSystem = @fkExternalDataSystem)
 AND 	(@Query IS NULL OR Query LIKE @Query + '%')
