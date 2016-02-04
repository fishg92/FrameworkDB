CREATE TABLE [dbo].[JoinApplicationUserRefCredentialType] (
    [pkJoinApplicationUserRefCredentialType] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]                      DECIMAL (18)  NOT NULL,
    [fkRefCredentialType]                    DECIMAL (18)  NOT NULL,
    [UserName]                               VARCHAR (50)  NULL,
    [Password]                               VARCHAR (200) NULL,
    [LUPUser]                                VARCHAR (50)  NULL,
    [LUPDate]                                DATETIME      NULL,
    [CreateUser]                             VARCHAR (50)  NULL,
    [CreateDate]                             DATETIME      NULL,
    CONSTRAINT [PK_JoinApplicationUserRefCredentialType] PRIMARY KEY CLUSTERED ([pkJoinApplicationUserRefCredentialType] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser_fkrefCredentialType]
    ON [dbo].[JoinApplicationUserRefCredentialType]([fkApplicationUser] ASC, [fkRefCredentialType] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkRefCredentialType]
    ON [dbo].[JoinApplicationUserRefCredentialType]([fkRefCredentialType] ASC)
    INCLUDE([fkApplicationUser]);


GO
CREATE Trigger [dbo].[tr_JoinApplicationUserRefCredentialTypeAudit_UI] On [dbo].[JoinApplicationUserRefCredentialType]
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

Update JoinApplicationUserRefCredentialType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinApplicationUserRefCredentialType dbTable
	Inner Join Inserted i on dbtable.pkJoinApplicationUserRefCredentialType = i.pkJoinApplicationUserRefCredentialType
	Left Join Deleted d on d.pkJoinApplicationUserRefCredentialType = d.pkJoinApplicationUserRefCredentialType
	Where d.pkJoinApplicationUserRefCredentialType is null

Update JoinApplicationUserRefCredentialType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinApplicationUserRefCredentialType dbTable
	Inner Join Deleted d on dbTable.pkJoinApplicationUserRefCredentialType = d.pkJoinApplicationUserRefCredentialType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinApplicationUserRefCredentialTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinApplicationUserRefCredentialType] = i.[pkJoinApplicationUserRefCredentialType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinApplicationUserRefCredentialTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinApplicationUserRefCredentialType]
	,[fkApplicationUser]
	,[fkRefCredentialType]
	,[UserName]
	,[Password]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinApplicationUserRefCredentialType]
	,[fkApplicationUser]
	,[fkRefCredentialType]
	,[UserName]
	,[Password]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinApplicationUserRefCredentialTypeAudit_d] On [dbo].[JoinApplicationUserRefCredentialType]
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
From JoinApplicationUserRefCredentialTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinApplicationUserRefCredentialType] = d.[pkJoinApplicationUserRefCredentialType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinApplicationUserRefCredentialTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinApplicationUserRefCredentialType]
	,[fkApplicationUser]
	,[fkRefCredentialType]
	,[UserName]
	,[Password]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinApplicationUserRefCredentialType]
	,[fkApplicationUser]
	,[fkRefCredentialType]
	,[UserName]
	,[Password]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserRefCredentialType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserRefCredentialType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserRefCredentialType', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Join tables represent a many to many relationship between two or more tables. In this case, it models the relationships between external systems and ApplicationUsers. It also stores application users'' usernames and passwords. The passwords are encrypted.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserRefCredentialType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserRefCredentialType', @level2type = N'COLUMN', @level2name = N'pkJoinApplicationUserRefCredentialType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserRefCredentialType', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CredentialType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserRefCredentialType', @level2type = N'COLUMN', @level2name = N'fkRefCredentialType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Username for the external system', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserRefCredentialType', @level2type = N'COLUMN', @level2name = N'UserName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Encrypted password for the external system', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserRefCredentialType', @level2type = N'COLUMN', @level2name = N'Password';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserRefCredentialType', @level2type = N'COLUMN', @level2name = N'LUPUser';

