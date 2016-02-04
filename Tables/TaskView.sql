CREATE TABLE [dbo].[TaskView] (
    [pkTaskView]        DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser] DECIMAL (18)  CONSTRAINT [DF_TaskView_fkApplicationUser] DEFAULT ((-1)) NOT NULL,
    [ViewName]          VARCHAR (100) CONSTRAINT [DF_TaskView_ViewName] DEFAULT ('') NOT NULL,
    [IsGlobal]          BIT           CONSTRAINT [DF_TaskView_IsGlobal] DEFAULT ((0)) NOT NULL,
    [ShowUnread]        BIT           CONSTRAINT [DF_TaskView_ShowUnread] DEFAULT ((0)) NOT NULL,
    [IgnoreFilters]     BIT           CONSTRAINT [DF_TaskView_IgnoreFilters] DEFAULT ((0)) NOT NULL,
    [IncludeCompleted]  BIT           CONSTRAINT [DF_TaskView_IncludeCompleted] DEFAULT ((0)) NOT NULL,
    [CompletedDate]     DATETIME      NULL,
    [FromNumDaysSpan]   INT           CONSTRAINT [DF_TaskView_FromNumDaysSpan] DEFAULT ((0)) NOT NULL,
    [ColumnSettings]    VARCHAR (MAX) CONSTRAINT [DF_TaskView_ColumnSettings] DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_TaskView] PRIMARY KEY CLUSTERED ([pkTaskView] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[TaskView]([fkApplicationUser] ASC);


GO
CREATE Trigger [dbo].[tr_TaskViewAudit_UI] On [dbo].[TaskView]
FOR INSERT, UPDATE
As
SET NOCOUNT ON;

Declare @AuditUser varchar(50)
		,@AuditEndDate datetime
		,@AuditMachine varchar(15)
		,@Date datetime
		,@HostName varchar(50)

select @HostName = host_name()
		,@Date = getdate()

select @AuditUser = @HostName
		,@AuditMachine = ''
		
exec [dbo].[GetAuditDataFromContext] @AuditUser = @AuditUser output ,@AuditMachine = @AuditMachine output


--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From TaskViewAudit dbTable
Inner Join inserted i ON dbTable.[pkTaskView] = i.[pkTaskView]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into TaskViewAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkTaskView]
	,[fkApplicationUser]
	,[ViewName]
	,[IsGlobal]
	,[ShowUnread]
	,[IgnoreFilters]
	,[IncludeCompleted]
	,[CompletedDate]
	,[FromNumDaysSpan]
	,[ColumnSettings]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkTaskView]
	,[fkApplicationUser]
	,[ViewName]
	,[IsGlobal]
	,[ShowUnread]
	,[IgnoreFilters]
	,[IncludeCompleted]
	,[CompletedDate]
	,[FromNumDaysSpan]
	,[ColumnSettings]

From  Inserted
GO
CREATE Trigger [dbo].[tr_TaskViewAudit_d] On [dbo].[TaskView]
FOR Delete
As
SET NOCOUNT ON;

Declare @AuditUser varchar(50)
		,@AuditMachine varchar(15)
		,@Date datetime

select @Date = getdate()
select @AuditUser = host_name()
		,@AuditMachine = ''
		
exec [dbo].[GetAuditDataFromContext] @AuditUser = @AuditUser output ,@AuditMachine = @AuditMachine output

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From TaskViewAudit dbTable
Inner Join deleted d ON dbTable.[pkTaskView] = d.[pkTaskView]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into TaskViewAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkTaskView]
	,[fkApplicationUser]
	,[ViewName]
	,[IsGlobal]
	,[ShowUnread]
	,[IgnoreFilters]
	,[IncludeCompleted]
	,[CompletedDate]
	,[FromNumDaysSpan]
	,[ColumnSettings]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkTaskView]
	,[fkApplicationUser]
	,[ViewName]
	,[IsGlobal]
	,[ShowUnread]
	,[IgnoreFilters]
	,[IncludeCompleted]
	,[CompletedDate]
	,[FromNumDaysSpan]
	,[ColumnSettings]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores task views, which function much like the saved queries for Documents, to allow users to save specific task criteria to show items for a specific purpose.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskView', @level2type = N'COLUMN', @level2name = N'pkTaskView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Application User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskView', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User-friendly and defined description of the task', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskView', @level2type = N'COLUMN', @level2name = N'ViewName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is this a global view (1) or is it a view for an individual user (0)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskView', @level2type = N'COLUMN', @level2name = N'IsGlobal';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Should unread tasks be in the view (1) or not (0)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskView', @level2type = N'COLUMN', @level2name = N'ShowUnread';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ignore filters (1) or not (0)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskView', @level2type = N'COLUMN', @level2name = N'IgnoreFilters';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Include completed tasks (1) or not (0)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskView', @level2type = N'COLUMN', @level2name = N'IncludeCompleted';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'An apparently unused field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskView', @level2type = N'COLUMN', @level2name = N'CompletedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Number of days to show in the view', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskView', @level2type = N'COLUMN', @level2name = N'FromNumDaysSpan';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'String data to configure the grid view for the task list.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskView', @level2type = N'COLUMN', @level2name = N'ColumnSettings';

