CREATE TABLE [dbo].[RecipientPool] (
    [pkRecipientPool]           DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [Name]                      VARCHAR (100) NOT NULL,
    [LUPUser]                   VARCHAR (50)  NULL,
    [LUPDate]                   DATETIME      NULL,
    [CreateUser]                VARCHAR (50)  NULL,
    [CreateDate]                DATETIME      NULL,
    [PreviousTickListIndexUsed] INT           CONSTRAINT [DF_RecipientPool_NextTickListIndexToUse] DEFAULT ((-1)) NOT NULL,
    [Lockdate]                  DATETIME      NULL,
    [fkLockApplicationUser]     DECIMAL (18)  NULL,
    CONSTRAINT [PK_RecipientPool] PRIMARY KEY CLUSTERED ([pkRecipientPool] ASC)
);


GO
CREATE Trigger [dbo].[tr_RecipientPoolAudit_UI] On [dbo].[RecipientPool]
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

Update RecipientPool
	 Set [CreateUser] = @AuditUser
,[CreateDate] = @Date
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From RecipientPool dbTable
	Inner Join Inserted i on dbtable.pkRecipientPool = i.pkRecipientPool
	Left Join Deleted d on d.pkRecipientPool = d.pkRecipientPool
	Where d.pkRecipientPool is null

Update RecipientPool
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From RecipientPool dbTable
	Inner Join Deleted d on dbTable.pkRecipientPool = d.pkRecipientPool

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From RecipientPoolAudit dbTable
Inner Join inserted i ON dbTable.[pkRecipientPool] = i.[pkRecipientPool]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into RecipientPoolAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkRecipientPool]
	,[Name]
	,[PreviousTickListIndexUsed]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkRecipientPool]
	,[Name]
	,[PreviousTickListIndexUsed]

From  Inserted
GO
CREATE Trigger [dbo].[tr_RecipientPoolAudit_d] On [dbo].[RecipientPool]
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
From RecipientPoolAudit dbTable
Inner Join deleted d ON dbTable.[pkRecipientPool] = d.[pkRecipientPool]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into RecipientPoolAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkRecipientPool]
	,[Name]
	,[PreviousTickListIndexUsed]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkRecipientPool]
	,[Name]
	,[PreviousTickListIndexUsed]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This tables stores Recipient Pools', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RecipientPool';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RecipientPool', @level2type = N'COLUMN', @level2name = N'pkRecipientPool';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The friendly description of the recipient pool', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RecipientPool', @level2type = N'COLUMN', @level2name = N'Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RecipientPool', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RecipientPool', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RecipientPool', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RecipientPool', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The index of the item in JoinRecipientPoolTickListItem that was previously used as the suggested recipient. This will be -1 if the RecipientPool has not yet been used.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RecipientPool', @level2type = N'COLUMN', @level2name = N'PreviousTickListIndexUsed';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'the date the pool was locked', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RecipientPool', @level2type = N'COLUMN', @level2name = N'Lockdate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'the pk of the user who locked it', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RecipientPool', @level2type = N'COLUMN', @level2name = N'fkLockApplicationUser';

