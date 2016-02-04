----------------------------------------------------------------------------
-- Update a single record in EventType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspEventTypeUpdate]
(	  @pkEventType decimal(18, 0)
	, @Description varchar(250) = NULL
	, @fkProgramType decimal(18, 0) = NULL
	, @fkSmartView decimal(18, 0) = NULL
	, @IncludeCaseworkerCases bit = NULL
	, @IncludeFavoriteCases bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	EventType
SET	Description = ISNULL(@Description, Description),
	fkProgramType = ISNULL(@fkProgramType, fkProgramType),
	fkSmartView = ISNULL(@fkSmartView, fkSmartView),
	IncludeCaseworkerCases = ISNULL(@IncludeCaseworkerCases, IncludeCaseworkerCases),
	IncludeFavoriteCases = ISNULL(@IncludeFavoriteCases, IncludeFavoriteCases)
WHERE 	pkEventType = @pkEventType
