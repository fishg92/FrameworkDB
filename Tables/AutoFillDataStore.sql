CREATE TABLE [dbo].[AutoFillDataStore] (
    [pkAutoFillDataStore] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [FriendlyName]        VARCHAR (100) NOT NULL,
    [ConnectionType]      VARCHAR (100) NULL,
    [ConnectionString]    VARCHAR (500) NULL,
    [Enabled]             BIT           NULL,
    [LupUser]             VARCHAR (50)  NULL,
    [LupDate]             DATETIME      NULL,
    [CreateUser]          VARCHAR (50)  NULL,
    [CreateDate]          DATETIME      NULL,
    CONSTRAINT [PK_AutoFillDataStore] PRIMARY KEY CLUSTERED ([pkAutoFillDataStore] ASC)
);


GO
CREATE Trigger [dbo].[tr_AutoFillDataStoreAudit_UI] On [dbo].[AutoFillDataStore]
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

Update AutoFillDataStore
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From AutoFillDataStore dbTable
	Inner Join Inserted i on dbtable.pkAutoFillDataStore = i.pkAutoFillDataStore
	Left Join Deleted d on d.pkAutoFillDataStore = d.pkAutoFillDataStore
	Where d.pkAutoFillDataStore is null

Update AutoFillDataStore
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From AutoFillDataStore dbTable
	Inner Join Deleted d on dbTable.pkAutoFillDataStore = d.pkAutoFillDataStore
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From AutoFillDataStoreAudit dbTable
Inner Join inserted i ON dbTable.[pkAutoFillDataStore] = i.[pkAutoFillDataStore]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutoFillDataStoreAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutoFillDataStore]
	,[FriendlyName]
	,[ConnectionType]
	,[ConnectionString]
	,[Enabled]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkAutoFillDataStore]
	,[FriendlyName]
	,[ConnectionType]
	,[ConnectionString]
	,[Enabled]

From  Inserted
GO
CREATE Trigger [dbo].[tr_AutoFillDataStoreAudit_d] On [dbo].[AutoFillDataStore]
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
From AutoFillDataStoreAudit dbTable
Inner Join deleted d ON dbTable.[pkAutoFillDataStore] = d.[pkAutoFillDataStore]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutoFillDataStoreAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutoFillDataStore]
	,[FriendlyName]
	,[ConnectionType]
	,[ConnectionString]
	,[Enabled]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkAutoFillDataStore]
	,[FriendlyName]
	,[ConnectionType]
	,[ConnectionString]
	,[Enabled]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Base sources of autofill data (database servers, web services, etc.)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataStore';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataStore', @level2type = N'COLUMN', @level2name = N'pkAutoFillDataStore';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Common name of this data store', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataStore', @level2type = N'COLUMN', @level2name = N'FriendlyName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Type of connection needed to access this data store', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataStore', @level2type = N'COLUMN', @level2name = N'ConnectionType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Source-specific connection information needed to connect to this data store', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataStore', @level2type = N'COLUMN', @level2name = N'ConnectionString';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Flag to indicate that this data store is currently in use (0 = False, 1 = True)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataStore', @level2type = N'COLUMN', @level2name = N'Enabled';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataStore', @level2type = N'COLUMN', @level2name = N'LupUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataStore', @level2type = N'COLUMN', @level2name = N'LupDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataStore', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataStore', @level2type = N'COLUMN', @level2name = N'CreateDate';

