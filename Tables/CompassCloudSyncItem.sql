CREATE TABLE [dbo].[CompassCloudSyncItem] (
    [pkCompassCloudSyncItem] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkSyncItem]             VARCHAR (50)  NOT NULL,
    [SyncItemType]           DECIMAL (18)  NOT NULL,
    [FormallyKnownAs]        VARCHAR (50)  NOT NULL,
    [fkApplicationUser]      DECIMAL (18)  NOT NULL,
    [CloudItemID]            VARCHAR (250) CONSTRAINT [DF_Table_1_CloudID] DEFAULT ('-1') NOT NULL,
    [TimeStamp]              FLOAT (53)    NOT NULL,
    [ItemPageNumber]         INT           NOT NULL,
    [LUPUser]                VARCHAR (50)  NULL,
    [LUPDate]                DATETIME      NULL,
    [CreateUser]             VARCHAR (50)  NULL,
    [CreateDate]             DATETIME      NULL,
    CONSTRAINT [PK_CompassCloudSyncItem] PRIMARY KEY CLUSTERED ([pkCompassCloudSyncItem] ASC)
);


GO
CREATE NONCLUSTERED INDEX [FK_ApplicationUser]
    ON [dbo].[CompassCloudSyncItem]([fkApplicationUser] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_fkSyncItem_SyncItemType_fkApplicationUser]
    ON [dbo].[CompassCloudSyncItem]([fkSyncItem] ASC, [SyncItemType] ASC, [fkApplicationUser] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_GetCasesDeltaForCloudSync]
    ON [dbo].[CompassCloudSyncItem]([SyncItemType] ASC, [fkApplicationUser] ASC)
    INCLUDE([fkSyncItem], [FormallyKnownAs]);


GO
CREATE Trigger [dbo].[tr_CompassCloudSyncItemAudit_d] On [dbo].[CompassCloudSyncItem]
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
From CompassCloudSyncItemAudit dbTable
Inner Join deleted d ON dbTable.[pkCompassCloudSyncItem] = d.[pkCompassCloudSyncItem]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CompassCloudSyncItemAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCompassCloudSyncItem]
	,[fkSyncItem]
	,[SyncItemType]
	,[FormallyKnownAs]
	,[fkApplicationUser]
	,[CloudItemID]
	,[TimeStamp]
	,[ItemPageNumber]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCompassCloudSyncItem]
	,[fkSyncItem]
	,[SyncItemType]
	,[FormallyKnownAs]
	,[fkApplicationUser]
	,[CloudItemID]
	,[TimeStamp]
	,[ItemPageNumber]
From  Deleted
GO
CREATE Trigger [dbo].[tr_CompassCloudSyncItemAudit_UI] On [dbo].[CompassCloudSyncItem]
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

Update CompassCloudSyncItem
	 Set [CreateUser] = @AuditUser
,[CreateDate] = @Date
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From CompassCloudSyncItem dbTable
	Inner Join Inserted i on dbtable.pkCompassCloudSyncItem = i.pkCompassCloudSyncItem
	Left Join Deleted d on d.pkCompassCloudSyncItem = d.pkCompassCloudSyncItem
	Where d.pkCompassCloudSyncItem is null

Update CompassCloudSyncItem
	 Set [CreateUser] = d.CreateUser
,[CreateDate] = d.CreateDate
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From CompassCloudSyncItem dbTable
	Inner Join Deleted d on dbTable.pkCompassCloudSyncItem = d.pkCompassCloudSyncItem

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CompassCloudSyncItemAudit dbTable
Inner Join inserted i ON dbTable.[pkCompassCloudSyncItem] = i.[pkCompassCloudSyncItem]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CompassCloudSyncItemAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCompassCloudSyncItem]
	,[fkSyncItem]
	,[SyncItemType]
	,[FormallyKnownAs]
	,[fkApplicationUser]
	,[CloudItemID]
	,[TimeStamp]
	,[ItemPageNumber]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCompassCloudSyncItem]
	,[fkSyncItem]
	,[SyncItemType]
	,[FormallyKnownAs]
	,[fkApplicationUser]
	,[CloudItemID]
	,[TimeStamp]
	,[ItemPageNumber]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Sync Table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CompassCloudSyncItem';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary Key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CompassCloudSyncItem', @level2type = N'COLUMN', @level2name = N'pkCompassCloudSyncItem';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary key to Compass object stored in database (case, member, etc.)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CompassCloudSyncItem', @level2type = N'COLUMN', @level2name = N'fkSyncItem';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Type of Compass object (case, member, note, etc.)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CompassCloudSyncItem', @level2type = N'COLUMN', @level2name = N'SyncItemType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary key created in CoPilot for item', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CompassCloudSyncItem', @level2type = N'COLUMN', @level2name = N'FormallyKnownAs';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User the object belongs to', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CompassCloudSyncItem', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Custom ID to item when stored in the cloud', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CompassCloudSyncItem', @level2type = N'COLUMN', @level2name = N'CloudItemID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The timestamp of when the object was changed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CompassCloudSyncItem', @level2type = N'COLUMN', @level2name = N'TimeStamp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Page Number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CompassCloudSyncItem', @level2type = N'COLUMN', @level2name = N'ItemPageNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LUP User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CompassCloudSyncItem', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LUP Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CompassCloudSyncItem', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CompassCloudSyncItem', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CompassCloudSyncItem', @level2type = N'COLUMN', @level2name = N'CreateDate';

