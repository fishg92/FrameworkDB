----------------------------------------------------------------------------
-- Update a single record in TaskView
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaskViewUpdate]
(	  @pkTaskView decimal(18, 0)
	, @fkApplicationUser decimal(18, 0) = NULL
	, @ViewName varchar(100) = NULL
	, @IsGlobal bit = NULL
	, @ShowUnread bit = NULL
	, @IgnoreFilters bit = NULL
	, @IncludeCompleted bit = NULL
	, @CompletedDate datetime = NULL
	, @FromNumDaysSpan int = NULL
	, @ColumnSettings varchar(MAX) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	TaskView
SET	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser),
	ViewName = ISNULL(@ViewName, ViewName),
	IsGlobal = ISNULL(@IsGlobal, IsGlobal),
	ShowUnread = ISNULL(@ShowUnread, ShowUnread),
	IgnoreFilters = ISNULL(@IgnoreFilters, IgnoreFilters),
	IncludeCompleted = ISNULL(@IncludeCompleted, IncludeCompleted),
	CompletedDate = ISNULL(@CompletedDate, CompletedDate),
	FromNumDaysSpan = ISNULL(@FromNumDaysSpan, FromNumDaysSpan),
	ColumnSettings = ISNULL(@ColumnSettings, ColumnSettings)
WHERE 	pkTaskView = @pkTaskView
