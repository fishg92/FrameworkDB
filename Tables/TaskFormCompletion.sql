CREATE TABLE [dbo].[TaskFormCompletion] (
    [pkTaskFormCompletion] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkTask]               VARCHAR (50) NOT NULL,
    [fkCPClient]           DECIMAL (18) NOT NULL,
    [fkFormName]           DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_TaskFormCompletion] PRIMARY KEY CLUSTERED ([pkTaskFormCompletion] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkCPClient]
    ON [dbo].[TaskFormCompletion]([fkCPClient] ASC);


GO
CREATE NONCLUSTERED INDEX [fkFormName]
    ON [dbo].[TaskFormCompletion]([fkFormName] ASC);


GO
CREATE NONCLUSTERED INDEX [fkTask]
    ON [dbo].[TaskFormCompletion]([fkTask] ASC);


GO
CREATE Trigger [dbo].[tr_TaskFormCompletionAudit_d] On [dbo].[TaskFormCompletion]
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
From TaskFormCompletionAudit dbTable
Inner Join deleted d ON dbTable.[pkTaskFormCompletion] = d.[pkTaskFormCompletion]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into TaskFormCompletionAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkTaskFormCompletion]
	,[fkTask]
	,[fkCPClient]
	,[fkFormName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkTaskFormCompletion]
	,[fkTask]
	,[fkCPClient]
	,[fkFormName]
From  Deleted
GO
CREATE Trigger [dbo].[tr_TaskFormCompletionAudit_UI] On [dbo].[TaskFormCompletion]
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
From TaskFormCompletionAudit dbTable
Inner Join inserted i ON dbTable.[pkTaskFormCompletion] = i.[pkTaskFormCompletion]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into TaskFormCompletionAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkTaskFormCompletion]
	,[fkTask]
	,[fkCPClient]
	,[fkFormName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkTaskFormCompletion]
	,[fkTask]
	,[fkCPClient]
	,[fkFormName]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table is used to record completion of forms associated with tasks.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskFormCompletion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskFormCompletion', @level2type = N'COLUMN', @level2name = N'pkTaskFormCompletion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the Task table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskFormCompletion', @level2type = N'COLUMN', @level2name = N'fkTask';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPClient', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskFormCompletion', @level2type = N'COLUMN', @level2name = N'fkCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormName', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaskFormCompletion', @level2type = N'COLUMN', @level2name = N'fkFormName';

