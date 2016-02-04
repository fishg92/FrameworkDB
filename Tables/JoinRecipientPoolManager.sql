CREATE TABLE [dbo].[JoinRecipientPoolManager] (
    [pkJoinRecipientPoolManager] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkRecipientPool]            DECIMAL (18) NOT NULL,
    [fkApplicationUser]          DECIMAL (18) NOT NULL,
    [LUPUser]                    VARCHAR (50) NULL,
    [LUPDate]                    DATETIME     NULL,
    [CreateUser]                 VARCHAR (50) NULL,
    [CreateDate]                 DATETIME     NULL,
    CONSTRAINT [PK_JoinRecipientPoolManager] PRIMARY KEY CLUSTERED ([pkJoinRecipientPoolManager] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_JoinRecipientPoolManager_fkRecipientPool]
    ON [dbo].[JoinRecipientPoolManager]([fkRecipientPool] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_JoinRecipientPoolManager_fkApplicationUser]
    ON [dbo].[JoinRecipientPoolManager]([fkApplicationUser] ASC);


GO
CREATE Trigger [dbo].[tr_JoinRecipientPoolManagerAudit_UI] On [dbo].[JoinRecipientPoolManager]
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

Update JoinRecipientPoolManager
	 Set [CreateUser] = @AuditUser
,[CreateDate] = @Date
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From JoinRecipientPoolManager dbTable
	Inner Join Inserted i on dbtable.pkJoinRecipientPoolManager = i.pkJoinRecipientPoolManager
	Left Join Deleted d on d.pkJoinRecipientPoolManager = d.pkJoinRecipientPoolManager
	Where d.pkJoinRecipientPoolManager is null

Update JoinRecipientPoolManager
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinRecipientPoolManager dbTable
	Inner Join Deleted d on dbTable.pkJoinRecipientPoolManager = d.pkJoinRecipientPoolManager

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinRecipientPoolManagerAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinRecipientPoolManager] = i.[pkJoinRecipientPoolManager]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinRecipientPoolManagerAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinRecipientPoolManager]
	,[fkRecipientPool]
	,[fkApplicationUser]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinRecipientPoolManager]
	,[fkRecipientPool]
	,[fkApplicationUser]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinRecipientPoolManagerAudit_d] On [dbo].[JoinRecipientPoolManager]
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
From JoinRecipientPoolManagerAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinRecipientPoolManager] = d.[pkJoinRecipientPoolManager]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinRecipientPoolManagerAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinRecipientPoolManager]
	,[fkRecipientPool]
	,[fkApplicationUser]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinRecipientPoolManager]
	,[fkRecipientPool]
	,[fkApplicationUser]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table associates Recipient Pools with Pool Managers', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolManager';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolManager', @level2type = N'COLUMN', @level2name = N'pkJoinRecipientPoolManager';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The foreign key of the recipient pool in this relationship', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolManager', @level2type = N'COLUMN', @level2name = N'fkRecipientPool';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The foriegn key of the application user in this relationship', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolManager', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolManager', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolManager', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolManager', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolManager', @level2type = N'COLUMN', @level2name = N'CreateDate';

