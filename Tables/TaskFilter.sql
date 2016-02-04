CREATE TABLE [dbo].[TaskFilter] (
    [pkTaskFilter] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkTaskView]   DECIMAL (18)  NULL,
    [ParentNode]   VARCHAR (100) NULL,
    [Node]         VARCHAR (100) NULL,
    [TaskTab]      VARCHAR (100) NULL,
    CONSTRAINT [PK_TaskFilter] PRIMARY KEY CLUSTERED ([pkTaskFilter] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkTaskView]
    ON [dbo].[TaskFilter]([fkTaskView] ASC);


GO
CREATE Trigger [dbo].[tr_TaskFilterAudit_UI] On [dbo].[TaskFilter]
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
From TaskFilterAudit dbTable
Inner Join inserted i ON dbTable.[pkTaskFilter] = i.[pkTaskFilter]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into TaskFilterAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkTaskFilter]
	,[fkTaskView]
	,[ParentNode]
	,[Node]
	,[TaskTab]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkTaskFilter]
	,[fkTaskView]
	,[ParentNode]
	,[Node]
	,[TaskTab]

From  Inserted
GO
CREATE Trigger [dbo].[tr_TaskFilterAudit_d] On [dbo].[TaskFilter]
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
From TaskFilterAudit dbTable
Inner Join deleted d ON dbTable.[pkTaskFilter] = d.[pkTaskFilter]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into TaskFilterAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkTaskFilter]
	,[fkTaskView]
	,[ParentNode]
	,[Node]
	,[TaskTab]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkTaskFilter]
	,[fkTaskView]
	,[ParentNode]
	,[Node]
	,[TaskTab]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores the values for individual column criteria in a Task View.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskFilter';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskFilter', @level2type = N'COLUMN', @level2name = N'pkTaskFilter';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to TaskView', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskFilter', @level2type = N'COLUMN', @level2name = N'fkTaskView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The item that should be used to filter the task (E.G. DueDate)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskFilter', @level2type = N'COLUMN', @level2name = N'ParentNode';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The value that should be used to filter the task', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskFilter', @level2type = N'COLUMN', @level2name = N'Node';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The tab that the filter is associated with', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskFilter', @level2type = N'COLUMN', @level2name = N'TaskTab';

