----------------------------------------------------------------------------
-- Select a single record from EventType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspEventTypeSelect]
(	@pkEventType decimal(18, 0) = NULL,
	@Description varchar(250) = NULL,
	@fkProgramType decimal(18, 0) = NULL,
	@fkSmartView decimal(18, 0) = NULL,
	@IncludeCaseworkerCases bit = NULL,
	@IncludeFavoriteCases bit = NULL
)
AS

SELECT	pkEventType,
	Description,
	fkProgramType,
	fkSmartView,
	IncludeCaseworkerCases,
	IncludeFavoriteCases
FROM	EventType
WHERE 	(@pkEventType IS NULL OR pkEventType = @pkEventType)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')
 AND 	(@fkProgramType IS NULL OR fkProgramType = @fkProgramType)
 AND 	(@fkSmartView IS NULL OR fkSmartView = @fkSmartView)
 AND 	(@IncludeCaseworkerCases IS NULL OR IncludeCaseworkerCases = @IncludeCaseworkerCases)
 AND 	(@IncludeFavoriteCases IS NULL OR IncludeFavoriteCases = @IncludeFavoriteCases)
