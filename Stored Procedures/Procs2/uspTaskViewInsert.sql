----------------------------------------------------------------------------
-- Insert a single record into TaskView
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspTaskViewInsert]
(	  @fkApplicationUser decimal(18, 0) = NULL
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
	, @pkTaskView decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT TaskView
(	  fkApplicationUser
	, ViewName
	, IsGlobal
	, ShowUnread
	, IgnoreFilters
	, IncludeCompleted
	, CompletedDate
	, FromNumDaysSpan
	, ColumnSettings
)
VALUES 
(	  COALESCE(@fkApplicationUser, (-1))
	, COALESCE(@ViewName, '')
	, COALESCE(@IsGlobal, (0))
	, COALESCE(@ShowUnread, (0))
	, COALESCE(@IgnoreFilters, (0))
	, COALESCE(@IncludeCompleted, (0))
	, @CompletedDate
	, COALESCE(@FromNumDaysSpan, (0))
	, COALESCE(@ColumnSettings, '')

)

SET @pkTaskView = SCOPE_IDENTITY()
