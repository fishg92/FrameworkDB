CREATE TABLE [dbo].[ConnectType] (
    [pkConnectType]    DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [Description]      VARCHAR (250) NULL,
    [EnableCloudSync]  BIT           NULL,
    [SyncInterval]     INT           NULL,
    [LUPUser]          VARCHAR (50)  NULL,
    [LUPDate]          DATETIME      NULL,
    [CreateUser]       VARCHAR (50)  NULL,
    [CreateDate]       DATETIME      NULL,
    [SyncProviderType] VARCHAR (50)  NULL,
    CONSTRAINT [PK_TransferType] PRIMARY KEY CLUSTERED ([pkConnectType] ASC)
);


GO
CREATE Trigger tr_ConnectTypeAudit_UI On dbo.ConnectType
FOR INSERT, UPDATE
As
SET NOCOUNT ON;

Declare @AuditUser varchar(50)
		,@AuditEndDate datetime
		,@AuditMac char(17)
		,@AuditIP varchar(15)
		,@AuditMachine varchar(15)
		,@Date datetime
		,@HostName varchar(50)

select @HostName = host_name()
		,@Date = getdate()

select @AuditUser = @HostName
		,@AuditMac = ''
		,@AuditIP = ''
		,@AuditMachine = ''
		
select @AuditUser = LUPUser
		,@AuditMac = LUPMac
		,@AuditIP = LUPIp
		,@AuditMachine = LUPMachine
from TempAuditPurgeNightly with (NOLOCK)
where SPID = CONTEXT_INFO()

Update ConnectType
	 Set [CreateUser] = @AuditUser
,[CreateDate] = @Date
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From ConnectType dbTable
	Inner Join Inserted i on dbtable.pkConnectType = i.pkConnectType
	Left Join Deleted d on d.pkConnectType = d.pkConnectType
	Where d.pkConnectType is null

Update ConnectType
	 Set [CreateUser] = d.CreateUser
,[CreateDate] = d.CreateDate
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From ConnectType dbTable
	Inner Join Deleted d on dbTable.pkConnectType = d.pkConnectType

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From ConnectTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkConnectType] = i.[pkConnectType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ConnectTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMac
	, AuditIP
	, AuditMachine
	, AuditDeleted
	,[pkConnectType]
	,[Description]
	,[EnableCloudSync]
	,[SyncProviderType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMac
	, @AuditIP	
	, @AuditMachine
	, AuditDeleted = 0
	,[pkConnectType]
	,[Description]
	,[EnableCloudSync]
	,[SyncProviderType]
From  Inserted
GO
CREATE Trigger tr_ConnectTypeAudit_d On dbo.ConnectType
FOR Delete
As
SET NOCOUNT ON;

Declare @AuditUser varchar(50)
		,@AuditMac char(17)
		,@AuditIP varchar(15)
		,@AuditMachine varchar(15)
		,@Date datetime

select @Date = getdate()
select @AuditUser = host_name()
		,@AuditMac = ''
		,@AuditIP = ''
		,@AuditMachine = ''
		
select @AuditUser = LUPUser
		,@AuditMac = LUPMac
		,@AuditIP = LUPIp
		,@AuditMachine = LUPMachine
from TempAuditPurgeNightly with (NOLOCK)
where SPID = CONTEXT_INFO()

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From ConnectTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkConnectType] = d.[pkConnectType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ConnectTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMac
	, AuditIP
	, AuditMachine
	, AuditDeleted
	,[pkConnectType]
	,[Description]
	,[EnableCloudSync]
	,[SyncProviderType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMac
	, @AuditIP
	, @AuditMachine
	, AuditDeleted = 1
	,[pkConnectType]
	,[Description]
	,[EnableCloudSync]
	,[SyncProviderType]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used by Compass Connect to store types of connections', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConnectType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConnectType', @level2type = N'COLUMN', @level2name = N'pkConnectType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Common name of connection type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConnectType', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Flag to determine if CoPilot sync is performed connected or through the cloud.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConnectType', @level2type = N'COLUMN', @level2name = N'EnableCloudSync';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Value used to determine the timer interval for cloud syncs', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConnectType', @level2type = N'COLUMN', @level2name = N'SyncInterval';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used for Auditing', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConnectType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used for Auditing', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConnectType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used for Auditing', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConnectType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used for Auditing', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConnectType', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Value to determine which source/provider is used for syncs', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ConnectType', @level2type = N'COLUMN', @level2name = N'SyncProviderType';

