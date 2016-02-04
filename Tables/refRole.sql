CREATE TABLE [dbo].[refRole] (
    [pkrefRole]           DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [Description]         VARCHAR (255)  NOT NULL,
    [DetailedDescription] VARCHAR (2500) NULL,
    [fkrefRoleType]       DECIMAL (18)   NULL,
    [LUPUser]             VARCHAR (50)   NULL,
    [LUPDate]             DATETIME       NULL,
    [CreateUser]          VARCHAR (50)   NULL,
    [CreateDate]          DATETIME       NULL,
    [LDAPGroupMatch]      BIT            NULL,
    [LDAPDomainName]      VARCHAR (100)  NULL,
    CONSTRAINT [PK_refRole] PRIMARY KEY CLUSTERED ([pkrefRole] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkrefRoleType]
    ON [dbo].[refRole]([fkrefRoleType] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_refRoleAudit_d] On [dbo].[refRole]
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
From refRoleAudit dbTable
Inner Join deleted d ON dbTable.[pkrefRole] = d.[pkrefRole]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refRoleAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefRole]
	,[Description]
	,[DetailedDescription]
	,[fkrefRoleType]
	,[LDAPGroupMatch]
	,[LDAPDomainName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkrefRole]
	,[Description]
	,[DetailedDescription]
	,[fkrefRoleType]
	,[LDAPGroupMatch]
	,[LDAPDomainName]
From  Deleted
GO
CREATE Trigger [dbo].[tr_refRoleAudit_UI] On [dbo].[refRole]
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

Update refRole
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refRole dbTable
	Inner Join Inserted i on dbtable.pkrefRole = i.pkrefRole
	Left Join Deleted d on d.pkrefRole = d.pkrefRole
	Where d.pkrefRole is null

Update refRole
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refRole dbTable
	Inner Join Deleted d on dbTable.pkrefRole = d.pkrefRole
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From refRoleAudit dbTable
Inner Join inserted i ON dbTable.[pkrefRole] = i.[pkrefRole]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refRoleAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefRole]
	,[Description]
	,[DetailedDescription]
	,[fkrefRoleType]
	,[LDAPGroupMatch]
	,[LDAPDomainName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkrefRole]
	,[Description]
	,[DetailedDescription]
	,[fkrefRoleType]
	,[LDAPGroupMatch]
	,[LDAPDomainName]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table is a reference source for all the roles within Pilot and can link them to an LDAP source.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refRole';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refRole', @level2type = N'COLUMN', @level2name = N'pkrefRole';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Short description of the roll suitable for lists', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refRole', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Longer description of the role, if necessary', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refRole', @level2type = N'COLUMN', @level2name = N'DetailedDescription';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key describing the type of role', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refRole', @level2type = N'COLUMN', @level2name = N'fkrefRoleType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refRole', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refRole', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refRole', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refRole', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LDAP group that this role matches', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refRole', @level2type = N'COLUMN', @level2name = N'LDAPGroupMatch';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LDAP Domain name to check for the role', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refRole', @level2type = N'COLUMN', @level2name = N'LDAPDomainName';

