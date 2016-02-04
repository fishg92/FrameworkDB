----------------------------------------------------------------------------
-- Select a single record from TaskView
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaskViewSelect]
(	@pkTaskView decimal(18, 0) = NULL,
	@fkApplicationUser decimal(18, 0) = NULL,
	@ViewName varchar(100) = NULL,
	@IsGlobal bit = NULL,
	@ShowUnread bit = NULL,
	@IgnoreFilters bit = NULL,
	@IncludeCompleted bit = NULL,
	@CompletedDate datetime = NULL,
	@FromNumDaysSpan int = NULL,
	@ColumnSettings varchar(MAX) = NULL
)
AS

SELECT	pkTaskView,
	fkApplicationUser,
	ViewName,
	IsGlobal,
	ShowUnread,
	IgnoreFilters,
	IncludeCompleted,
	CompletedDate,
	FromNumDaysSpan,
	ColumnSettings
FROM	TaskView
WHERE 	(@pkTaskView IS NULL OR pkTaskView = @pkTaskView)
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)
 AND 	(@ViewName IS NULL OR ViewName LIKE @ViewName + '%')
 AND 	(@IsGlobal IS NULL OR IsGlobal = @IsGlobal)
 AND 	(@ShowUnread IS NULL OR ShowUnread = @ShowUnread)
 AND 	(@IgnoreFilters IS NULL OR IgnoreFilters = @IgnoreFilters)
 AND 	(@IncludeCompleted IS NULL OR IncludeCompleted = @IncludeCompleted)
 AND 	(@CompletedDate IS NULL OR CompletedDate = @CompletedDate)
 AND 	(@FromNumDaysSpan IS NULL OR FromNumDaysSpan = @FromNumDaysSpan)
 AND 	(@ColumnSettings IS NULL OR ColumnSettings LIKE @ColumnSettings + '%')
