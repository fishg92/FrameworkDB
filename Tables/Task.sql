CREATE TABLE [dbo].[Task] (
    [pkTask]          DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [fkrefTaskType]   DECIMAL (18)   NOT NULL,
    [Description]     VARCHAR (100)  CONSTRAINT [DF_Task_Description] DEFAULT ('') NOT NULL,
    [DueDate]         DATETIME       NULL,
    [Note]            VARCHAR (2000) CONSTRAINT [DF_Task_Note] DEFAULT ('') NOT NULL,
    [fkrefTaskStatus] DECIMAL (18)   NOT NULL,
    [Priority]        TINYINT        CONSTRAINT [DF_Task_Priority] DEFAULT ((2)) NOT NULL,
    [StartDate]       DATETIME       NULL,
    [CompleteDate]    DATETIME       NULL,
    [GroupTask]       BIT            CONSTRAINT [DF_Task_GroupTask] DEFAULT ((0)) NOT NULL,
    [LUPUser]         VARCHAR (50)   NULL,
    [LUPDate]         DATETIME       NULL,
    [CreateUser]      VARCHAR (50)   NULL,
    [CreateDate]      DATETIME       NULL,
    [SourceModuleID]  INT            NULL,
    [fkrefTaskOrigin] DECIMAL (18)   CONSTRAINT [DF_Task_fkrefTaskOrigin] DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED ([pkTask] ASC),
    CONSTRAINT [CK_TaskPriority] CHECK ([Priority]=(3) OR [Priority]=(2) OR [Priority]=(1))
);


GO
CREATE NONCLUSTERED INDEX [fkrefTaskOrigin]
    ON [dbo].[Task]([fkrefTaskOrigin] ASC);


GO
CREATE NONCLUSTERED INDEX [fkrefTaskStatus_DueDate]
    ON [dbo].[Task]([fkrefTaskStatus] ASC, [DueDate] ASC);


GO
CREATE NONCLUSTERED INDEX [fkrefTaskType]
    ON [dbo].[Task]([fkrefTaskType] ASC);


GO
CREATE Trigger [dbo].[tr_TaskAudit_d] On [dbo].[Task]
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
From TaskAudit dbTable
Inner Join deleted d ON dbTable.[pkTask] = d.[pkTask]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into TaskAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkTask]
	,[fkrefTaskType]
	,[Description]
	,[DueDate]
	,[Note]
	,[fkrefTaskStatus]
	,[Priority]
	,[StartDate]
	,[CompleteDate]
	,[GroupTask]
	,[SourceModuleID]
	,[fkrefTaskOrigin]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkTask]
	,[fkrefTaskType]
	,[Description]
	,[DueDate]
	,[Note]
	,[fkrefTaskStatus]
	,[Priority]
	,[StartDate]
	,[CompleteDate]
	,[GroupTask]
	,[SourceModuleID]
	,[fkrefTaskOrigin]
From  Deleted
GO
CREATE Trigger [dbo].[tr_TaskAudit_UI] On [dbo].[Task]
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

Update Task
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From Task dbTable
	Inner Join Inserted i on dbtable.pkTask = i.pkTask
	Left Join Deleted d on d.pkTask = d.pkTask
	Where d.pkTask is null

Update Task
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From Task dbTable
	Inner Join Deleted d on dbTable.pkTask = d.pkTask
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From TaskAudit dbTable
Inner Join inserted i ON dbTable.[pkTask] = i.[pkTask]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into TaskAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkTask]
	,[fkrefTaskType]
	,[Description]
	,[DueDate]
	,[Note]
	,[fkrefTaskStatus]
	,[Priority]
	,[StartDate]
	,[CompleteDate]
	,[GroupTask]
	,[SourceModuleID]
	,[fkrefTaskOrigin]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkTask]
	,[fkrefTaskType]
	,[Description]
	,[DueDate]
	,[Note]
	,[fkrefTaskStatus]
	,[Priority]
	,[StartDate]
	,[CompleteDate]
	,[GroupTask]
	,[SourceModuleID]
	,[fkrefTaskOrigin]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lock priority to 1,2,3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Task', @level2type = N'CONSTRAINT', @level2name = N'CK_TaskPriority';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table is the central table in Tasks and stores individual tasks.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Task';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Task', @level2type = N'COLUMN', @level2name = N'pkTask';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to refTaskType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Task', @level2type = N'COLUMN', @level2name = N'fkrefTaskType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the task', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Task', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Task due date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Task', @level2type = N'COLUMN', @level2name = N'DueDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Long, open, notes section for the task', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Task', @level2type = N'COLUMN', @level2name = N'Note';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to refTaskStatus', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Task', @level2type = N'COLUMN', @level2name = N'fkrefTaskStatus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Task priority (essentially a reference to refTaskPriority, but 1 is high, 3 is low)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Task', @level2type = N'COLUMN', @level2name = N'Priority';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date that the task was started', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Task', @level2type = N'COLUMN', @level2name = N'StartDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date that the task was completed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Task', @level2type = N'COLUMN', @level2name = N'CompleteDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'If the task is a group task, 1, if not, 0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Task', @level2type = N'COLUMN', @level2name = N'GroupTask';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Task', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Task', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Task', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Task', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Module that originated the task', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Task', @level2type = N'COLUMN', @level2name = N'SourceModuleID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Interaction type that originated the task', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Task', @level2type = N'COLUMN', @level2name = N'fkrefTaskOrigin';

