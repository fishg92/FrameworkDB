CREATE TABLE [dbo].[LDAPDomain] (
    [pkLDAPDomain] INT           IDENTITY (1, 1) NOT NULL,
    [Domain]       VARCHAR (255) NOT NULL,
    [LDAPUsername] VARCHAR (100) NULL,
    [LDAPPassword] VARCHAR (100) NULL,
    [LUPUser]      VARCHAR (50)  NULL,
    [LUPDate]      DATETIME      NULL,
    [CreateUser]   VARCHAR (50)  NULL,
    [CreateDate]   DATETIME      NULL,
    CONSTRAINT [PK_LDAPDomain] PRIMARY KEY CLUSTERED ([pkLDAPDomain] ASC)
);


GO
CREATE Trigger [dbo].[tr_LDAPDomainAudit_UI] On [dbo].[LDAPDomain]
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

Update LDAPDomain
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From LDAPDomain dbTable
	Inner Join Inserted i on dbtable.pkLDAPDomain = i.pkLDAPDomain
	Left Join Deleted d on d.pkLDAPDomain = d.pkLDAPDomain
	Where d.pkLDAPDomain is null

Update LDAPDomain
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From LDAPDomain dbTable
	Inner Join Deleted d on dbTable.pkLDAPDomain = d.pkLDAPDomain
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From LDAPDomainAudit dbTable
Inner Join inserted i ON dbTable.[pkLDAPDomain] = i.[pkLDAPDomain]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into LDAPDomainAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkLDAPDomain]
	,[Domain]
	,[LDAPUsername]
	,[LDAPPassword]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkLDAPDomain]
	,[Domain]
	,[LDAPUsername]
	,[LDAPPassword]

From  Inserted
GO
CREATE Trigger [dbo].[tr_LDAPDomainAudit_d] On [dbo].[LDAPDomain]
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
From LDAPDomainAudit dbTable
Inner Join deleted d ON dbTable.[pkLDAPDomain] = d.[pkLDAPDomain]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into LDAPDomainAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkLDAPDomain]
	,[Domain]
	,[LDAPUsername]
	,[LDAPPassword]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkLDAPDomain]
	,[Domain]
	,[LDAPUsername]
	,[LDAPPassword]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Contains information needed to query LDAP databases when LDAP integrated security is implemened', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LDAPDomain';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LDAPDomain', @level2type = N'COLUMN', @level2name = N'pkLDAPDomain';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Domain CN', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LDAPDomain', @level2type = N'COLUMN', @level2name = N'Domain';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Username to use to connect to the LDAP store', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LDAPDomain', @level2type = N'COLUMN', @level2name = N'LDAPUsername';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'(Encrypted) LDAP password', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LDAPDomain', @level2type = N'COLUMN', @level2name = N'LDAPPassword';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LDAPDomain', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LDAPDomain', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LDAPDomain', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LDAPDomain', @level2type = N'COLUMN', @level2name = N'CreateDate';

