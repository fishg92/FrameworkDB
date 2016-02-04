CREATE TABLE [dbo].[JoinRecipientPoolMember] (
    [pkJoinRecipientPoolMember] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkRecipientPool]           DECIMAL (18) NOT NULL,
    [fkApplicationUser]         DECIMAL (18) NOT NULL,
    [LUPUser]                   VARCHAR (50) NULL,
    [LUPDate]                   DATETIME     NULL,
    [CreateUser]                VARCHAR (50) NULL,
    [CreateDate]                DATETIME     NULL,
    CONSTRAINT [PK_JoinRecipientPoolMember] PRIMARY KEY CLUSTERED ([pkJoinRecipientPoolMember] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_JoinRecipientPoolMember_fkRecipientPool]
    ON [dbo].[JoinRecipientPoolMember]([fkRecipientPool] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_JoinRecipientPoolMember_fkApplicationUser]
    ON [dbo].[JoinRecipientPoolMember]([fkApplicationUser] ASC);


GO
CREATE Trigger [dbo].[tr_JoinRecipientPoolMemberAudit_d] On [dbo].[JoinRecipientPoolMember]
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
From JoinRecipientPoolMemberAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinRecipientPoolMember] = d.[pkJoinRecipientPoolMember]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinRecipientPoolMemberAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinRecipientPoolMember]
	,[fkRecipientPool]
	,[fkApplicationUser]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinRecipientPoolMember]
	,[fkRecipientPool]
	,[fkApplicationUser]
From  Deleted
GO
CREATE Trigger [dbo].[tr_JoinRecipientPoolMemberAudit_UI] On [dbo].[JoinRecipientPoolMember]
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

Update JoinRecipientPoolMember
	 Set [CreateUser] = @AuditUser
,[CreateDate] = @Date
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From JoinRecipientPoolMember dbTable
	Inner Join Inserted i on dbtable.pkJoinRecipientPoolMember = i.pkJoinRecipientPoolMember
	Left Join Deleted d on d.pkJoinRecipientPoolMember = d.pkJoinRecipientPoolMember
	Where d.pkJoinRecipientPoolMember is null

Update JoinRecipientPoolMember
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinRecipientPoolMember dbTable
	Inner Join Deleted d on dbTable.pkJoinRecipientPoolMember = d.pkJoinRecipientPoolMember

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinRecipientPoolMemberAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinRecipientPoolMember] = i.[pkJoinRecipientPoolMember]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinRecipientPoolMemberAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinRecipientPoolMember]
	,[fkRecipientPool]
	,[fkApplicationUser]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinRecipientPoolMember]
	,[fkRecipientPool]
	,[fkApplicationUser]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Associates application users with Recipient Pools as managers of that pool', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolMember';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolMember', @level2type = N'COLUMN', @level2name = N'pkJoinRecipientPoolMember';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key identifying the Recipient Pool in this relationship', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolMember', @level2type = N'COLUMN', @level2name = N'fkRecipientPool';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key identifying the Member in this relationship', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolMember', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolMember', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolMember', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolMember', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolMember', @level2type = N'COLUMN', @level2name = N'CreateDate';

