CREATE TABLE [dbo].[AutoFillDataSource] (
    [pkAutoFillDataSource] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkAutoFillDataStore]  DECIMAL (18)  NOT NULL,
    [FriendlyName]         VARCHAR (100) NOT NULL,
    [ProcName]             VARCHAR (100) NOT NULL,
    [LupUser]              VARCHAR (50)  NULL,
    [LupDate]              DATETIME      NULL,
    [CreateUser]           VARCHAR (50)  NULL,
    [CreateDate]           DATETIME      NULL,
    CONSTRAINT [PK_AutoFillDataSource] PRIMARY KEY CLUSTERED ([pkAutoFillDataSource] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkAutoFillDataSource]
    ON [dbo].[AutoFillDataSource]([fkAutoFillDataStore] ASC);


GO
CREATE Trigger [dbo].[tr_AutoFillDataSourceAudit_d] On [dbo].[AutoFillDataSource]
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
From AutoFillDataSourceAudit dbTable
Inner Join deleted d ON dbTable.[pkAutoFillDataSource] = d.[pkAutoFillDataSource]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutoFillDataSourceAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutoFillDataSource]
	,[fkAutoFillDataStore]
	,[FriendlyName]
	,[ProcName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkAutoFillDataSource]
	,[fkAutoFillDataStore]
	,[FriendlyName]
	,[ProcName]
From  Deleted
GO
CREATE Trigger [dbo].[tr_AutoFillDataSourceAudit_UI] On [dbo].[AutoFillDataSource]
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

Update AutoFillDataSource
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From AutoFillDataSource dbTable
	Inner Join Inserted i on dbtable.pkAutoFillDataSource = i.pkAutoFillDataSource
	Left Join Deleted d on d.pkAutoFillDataSource = d.pkAutoFillDataSource
	Where d.pkAutoFillDataSource is null

Update AutoFillDataSource
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From AutoFillDataSource dbTable
	Inner Join Deleted d on dbTable.pkAutoFillDataSource = d.pkAutoFillDataSource
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From AutoFillDataSourceAudit dbTable
Inner Join inserted i ON dbTable.[pkAutoFillDataSource] = i.[pkAutoFillDataSource]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutoFillDataSourceAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutoFillDataSource]
	,[fkAutoFillDataStore]
	,[FriendlyName]
	,[ProcName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkAutoFillDataSource]
	,[fkAutoFillDataStore]
	,[FriendlyName]
	,[ProcName]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataSource', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataSource', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Contains information about available sources of autofill data used for document keyword lookup', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataSource';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataSource', @level2type = N'COLUMN', @level2name = N'pkAutoFillDataSource';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to AutoFillDataStore table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataSource', @level2type = N'COLUMN', @level2name = N'fkAutoFillDataStore';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Common description for this data source', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataSource', @level2type = N'COLUMN', @level2name = N'FriendlyName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Procedure to be executed in the associated data store', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataSource', @level2type = N'COLUMN', @level2name = N'ProcName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataSource', @level2type = N'COLUMN', @level2name = N'LupUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataSource', @level2type = N'COLUMN', @level2name = N'LupDate';

