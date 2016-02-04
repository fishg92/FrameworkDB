CREATE TABLE [dbo].[ExternalTaskMetaData] (
    [pkExternalTaskMetaData] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkExternalTask]         VARCHAR (50) NOT NULL,
    [fkrefTaskPriority]      DECIMAL (18) CONSTRAINT [DF_ExternalTaskMetaData_fkrefTaskPriority] DEFAULT ((2)) NOT NULL,
    [fkrefTaskStatus]        DECIMAL (18) CONSTRAINT [DF_ExternalTaskMetaData_fkrefTaskStatus] DEFAULT ((1)) NOT NULL,
    [fkrefTaskOrigin]        DECIMAL (18) CONSTRAINT [DF_ExternalTaskMetaData_fkrefTaskOrigin] DEFAULT ((-1)) NOT NULL,
    [SourceModuleID]         INT          NULL,
    CONSTRAINT [PK_ExternalTaskMetaData] PRIMARY KEY CLUSTERED ([pkExternalTaskMetaData] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [fkExternalTask_Unique]
    ON [dbo].[ExternalTaskMetaData]([fkExternalTask] ASC);


GO
CREATE NONCLUSTERED INDEX [fkrefTaskOrigin]
    ON [dbo].[ExternalTaskMetaData]([fkrefTaskOrigin] ASC);


GO
CREATE NONCLUSTERED INDEX [fkrefTaskPriority]
    ON [dbo].[ExternalTaskMetaData]([fkrefTaskPriority] ASC);


GO
CREATE NONCLUSTERED INDEX [fkrefTaskStatus]
    ON [dbo].[ExternalTaskMetaData]([fkrefTaskStatus] ASC);


GO
CREATE Trigger [dbo].[tr_ExternalTaskMetaDataAudit_d] On [dbo].[ExternalTaskMetaData]
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
From ExternalTaskMetaDataAudit dbTable
Inner Join deleted d ON dbTable.[pkExternalTaskMetaData] = d.[pkExternalTaskMetaData]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ExternalTaskMetaDataAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkExternalTaskMetaData]
	,[fkExternalTask]
	,[fkrefTaskPriority]
	,[fkrefTaskStatus]
	,[fkrefTaskOrigin]
	,[SourceModuleID]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkExternalTaskMetaData]
	,[fkExternalTask]
	,[fkrefTaskPriority]
	,[fkrefTaskStatus]
	,[fkrefTaskOrigin]
	,[SourceModuleID]
From  Deleted
GO
CREATE Trigger [dbo].[tr_ExternalTaskMetaDataAudit_UI] On [dbo].[ExternalTaskMetaData]
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
From ExternalTaskMetaDataAudit dbTable
Inner Join inserted i ON dbTable.[pkExternalTaskMetaData] = i.[pkExternalTaskMetaData]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ExternalTaskMetaDataAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkExternalTaskMetaData]
	,[fkExternalTask]
	,[fkrefTaskPriority]
	,[fkrefTaskStatus]
	,[fkrefTaskOrigin]
	,[SourceModuleID]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkExternalTaskMetaData]
	,[fkExternalTask]
	,[fkrefTaskPriority]
	,[fkrefTaskStatus]
	,[fkrefTaskOrigin]
	,[SourceModuleID]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key representing an external task', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalTaskMetaData', @level2type = N'COLUMN', @level2name = N'fkExternalTask';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the TaskPriority reference table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalTaskMetaData', @level2type = N'COLUMN', @level2name = N'fkrefTaskPriority';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the TaskStatus reference table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalTaskMetaData', @level2type = N'COLUMN', @level2name = N'fkrefTaskStatus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the TaskOrigin reference table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalTaskMetaData', @level2type = N'COLUMN', @level2name = N'fkrefTaskOrigin';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ID number to represent the application that created the task', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalTaskMetaData', @level2type = N'COLUMN', @level2name = N'SourceModuleID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table pulls Pilot Task meta data to join to a task in an external system.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalTaskMetaData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ExternalTaskMetaData', @level2type = N'COLUMN', @level2name = N'pkExternalTaskMetaData';

