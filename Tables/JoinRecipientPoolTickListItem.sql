CREATE TABLE [dbo].[JoinRecipientPoolTickListItem] (
    [pkJoinRecipientPoolTickListItem] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkRecipientPool]                 DECIMAL (18) NOT NULL,
    [fkApplicationUser]               DECIMAL (18) NOT NULL,
    [TickListIndex]                   INT          NOT NULL,
    [LUPUser]                         VARCHAR (50) NULL,
    [LUPDate]                         DATETIME     NULL,
    [CreateUser]                      VARCHAR (50) NULL,
    [CreateDate]                      DATETIME     NULL,
    [Selected]                        BIT          DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_JoinRecipientPoolTickListItem] PRIMARY KEY CLUSTERED ([pkJoinRecipientPoolTickListItem] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_JoinRecipientPoolTickListItem_fkRecipientPool]
    ON [dbo].[JoinRecipientPoolTickListItem]([fkRecipientPool] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_JoinRecipientPoolTickListItem_fkApplicationUser]
    ON [dbo].[JoinRecipientPoolTickListItem]([fkApplicationUser] ASC);


GO
CREATE Trigger [dbo].[tr_JoinRecipientPoolTickListItemAudit_UI] On [dbo].[JoinRecipientPoolTickListItem]
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

Update JoinRecipientPoolTickListItem
	 Set [CreateUser] = @AuditUser
,[CreateDate] = @Date
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From JoinRecipientPoolTickListItem dbTable
	Inner Join Inserted i on dbtable.pkJoinRecipientPoolTickListItem = i.pkJoinRecipientPoolTickListItem
	Left Join Deleted d on d.pkJoinRecipientPoolTickListItem = d.pkJoinRecipientPoolTickListItem
	Where d.pkJoinRecipientPoolTickListItem is null

Update JoinRecipientPoolTickListItem
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinRecipientPoolTickListItem dbTable
	Inner Join Deleted d on dbTable.pkJoinRecipientPoolTickListItem = d.pkJoinRecipientPoolTickListItem

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinRecipientPoolTickListItemAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinRecipientPoolTickListItem] = i.[pkJoinRecipientPoolTickListItem]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinRecipientPoolTickListItemAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinRecipientPoolTickListItem]
	,[fkRecipientPool]
	,[fkApplicationUser]
	,[TickListIndex]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinRecipientPoolTickListItem]
	,[fkRecipientPool]
	,[fkApplicationUser]
	,[TickListIndex]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinRecipientPoolTickListItemAudit_d] On [dbo].[JoinRecipientPoolTickListItem]
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
From JoinRecipientPoolTickListItemAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinRecipientPoolTickListItem] = d.[pkJoinRecipientPoolTickListItem]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinRecipientPoolTickListItemAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinRecipientPoolTickListItem]
	,[fkRecipientPool]
	,[fkApplicationUser]
	,[TickListIndex]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinRecipientPoolTickListItem]
	,[fkRecipientPool]
	,[fkApplicationUser]
	,[TickListIndex]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Associates application users with Recipient Pools as members of the Tick List for the Recipient Pool, with a specific index within the List''s rotation', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolTickListItem';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolTickListItem', @level2type = N'COLUMN', @level2name = N'pkJoinRecipientPoolTickListItem';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The foreign key of the recipient pool in this relationship', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolTickListItem', @level2type = N'COLUMN', @level2name = N'fkRecipientPool';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The foriegn key of the application user in this relationship', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolTickListItem', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The index that this item occupies in the tick list order', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolTickListItem', @level2type = N'COLUMN', @level2name = N'TickListIndex';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolTickListItem', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolTickListItem', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolTickListItem', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolTickListItem', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Marks this item as the last one selected', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolTickListItem', @level2type = N'COLUMN', @level2name = N'Selected';

