CREATE TABLE [dbo].[TaskViewTaskTypeDeselected] (
    [pkTaskViewTaskTypeDeselected] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkTaskView]                   DECIMAL (18) NOT NULL,
    [fkrefTaskType]                DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_TaskViewTaskTypeDeselected] PRIMARY KEY CLUSTERED ([pkTaskViewTaskTypeDeselected] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_TaskViewTaskTypeDeselected]
    ON [dbo].[TaskViewTaskTypeDeselected]([fkTaskView] ASC, [fkrefTaskType] ASC);


GO
CREATE NONCLUSTERED INDEX [fkrefTaskType]
    ON [dbo].[TaskViewTaskTypeDeselected]([fkrefTaskType] ASC);


GO
CREATE Trigger [dbo].[tr_TaskViewTaskTypeDeselectedAudit_UI] On [dbo].[TaskViewTaskTypeDeselected]
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
From TaskViewTaskTypeDeselectedAudit dbTable
Inner Join inserted i ON dbTable.[pkTaskViewTaskTypeDeselected] = i.[pkTaskViewTaskTypeDeselected]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into TaskViewTaskTypeDeselectedAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkTaskViewTaskTypeDeselected]
	,[fkTaskView]
	,[fkrefTaskType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkTaskViewTaskTypeDeselected]
	,[fkTaskView]
	,[fkrefTaskType]

From  Inserted
GO
CREATE Trigger [dbo].[tr_TaskViewTaskTypeDeselectedAudit_d] On [dbo].[TaskViewTaskTypeDeselected]
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
From TaskViewTaskTypeDeselectedAudit dbTable
Inner Join deleted d ON dbTable.[pkTaskViewTaskTypeDeselected] = d.[pkTaskViewTaskTypeDeselected]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into TaskViewTaskTypeDeselectedAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkTaskViewTaskTypeDeselected]
	,[fkTaskView]
	,[fkrefTaskType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkTaskViewTaskTypeDeselected]
	,[fkTaskView]
	,[fkrefTaskType]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table lists the TaskTypes that should NOT appear in a specified view. By showing the task types that shouldn''t appear, when new task types are added they are automatically included in Task Views.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskViewTaskTypeDeselected';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskViewTaskTypeDeselected', @level2type = N'COLUMN', @level2name = N'pkTaskViewTaskTypeDeselected';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Task View', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskViewTaskTypeDeselected', @level2type = N'COLUMN', @level2name = N'fkTaskView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to refTaskType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskViewTaskTypeDeselected', @level2type = N'COLUMN', @level2name = N'fkrefTaskType';

