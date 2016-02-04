CREATE TABLE [dbo].[ApplicationUser] (
    [pkApplicationUser] DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [UserName]          VARCHAR (50)   NOT NULL,
    [FirstName]         VARCHAR (50)   NOT NULL,
    [LastName]          VARCHAR (50)   NOT NULL,
    [Password]          VARCHAR (100)  NOT NULL,
    [fkDepartment]      DECIMAL (18)   NULL,
    [LUPUser]           VARCHAR (50)   NULL,
    [LUPDate]           DATETIME       NULL,
    [CreateUser]        VARCHAR (50)   NULL,
    [CreateDate]        DATETIME       NULL,
    [WorkerNumber]      VARCHAR (50)   NULL,
    [LDAPUser]          BIT            NULL,
    [LDAPUniqueID]      VARCHAR (100)  NULL,
    [CountyCode]        VARCHAR (50)   CONSTRAINT [DF_ApplicationUser_CountyCode] DEFAULT ('') NULL,
    [MiddleName]        VARCHAR (50)   NULL,
    [eMail]             VARCHAR (50)   NULL,
    [IsCaseworker]      BIT            CONSTRAINT [DF_ApplicationUser_IsCaseworker] DEFAULT ((1)) NULL,
    [IsActive]          BIT            NULL,
    [eCAFFirstName]     VARCHAR (50)   NULL,
    [eCAFLastName]      VARCHAR (50)   NULL,
    [StateID]           VARCHAR (50)   NULL,
    [PhoneNumber]       VARCHAR (10)   NULL,
    [Extension]         VARCHAR (10)   NULL,
    [ExternalIDNumber]  NVARCHAR (150) NULL,
    CONSTRAINT [PK_ApplicationUser] PRIMARY KEY CLUSTERED ([pkApplicationUser] ASC)
);


GO
CREATE NONCLUSTERED INDEX [UserName]
    ON [dbo].[ApplicationUser]([UserName] ASC);


GO
CREATE NONCLUSTERED INDEX [fkDepartment]
    ON [dbo].[ApplicationUser]([fkDepartment] ASC);


GO
CREATE Trigger tr_ApplicationUserAudit_UI On ApplicationUser
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

Update ApplicationUser
	 Set [CreateUser] = @AuditUser
,[CreateDate] = @Date
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From ApplicationUser dbTable
	Inner Join Inserted i on dbtable.pkApplicationUser = i.pkApplicationUser
	Left Join Deleted d on d.pkApplicationUser = d.pkApplicationUser
	Where d.pkApplicationUser is null

Update ApplicationUser
	 Set [CreateUser] = d.CreateUser
,[CreateDate] = d.CreateDate
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From ApplicationUser dbTable
	Inner Join Deleted d on dbTable.pkApplicationUser = d.pkApplicationUser

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From ApplicationUserAudit dbTable
Inner Join inserted i ON dbTable.[pkApplicationUser] = i.[pkApplicationUser]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ApplicationUserAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkApplicationUser]
	,[UserName]
	,[FirstName]
	,[LastName]
	,[Password]
	,[fkDepartment]
	,[WorkerNumber]
	,[LDAPUser]
	,[LDAPUniqueID]
	,[CountyCode]
	,[MiddleName]
	,[eMail]
	,[IsCaseworker]
	,[IsActive]
	,[eCAFFirstName]
	,[eCAFLastName]
	,[StateID]
	,[PhoneNumber]
	,[Extension]
	,[ExternalIDNumber]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkApplicationUser]
	,[UserName]
	,[FirstName]
	,[LastName]
	,[Password]
	,[fkDepartment]
	,[WorkerNumber]
	,[LDAPUser]
	,[LDAPUniqueID]
	,[CountyCode]
	,[MiddleName]
	,[eMail]
	,[IsCaseworker]
	,[IsActive]
	,[eCAFFirstName]
	,[eCAFLastName]
	,[StateID]
	,[PhoneNumber]
	,[Extension]
	,[ExternalIDNumber]

From  Inserted
GO
CREATE Trigger tr_ApplicationUserAudit_d On ApplicationUser
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
From ApplicationUserAudit dbTable
Inner Join deleted d ON dbTable.[pkApplicationUser] = d.[pkApplicationUser]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ApplicationUserAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkApplicationUser]
	,[UserName]
	,[FirstName]
	,[LastName]
	,[Password]
	,[fkDepartment]
	,[WorkerNumber]
	,[LDAPUser]
	,[LDAPUniqueID]
	,[CountyCode]
	,[MiddleName]
	,[eMail]
	,[IsCaseworker]
	,[IsActive]
	,[eCAFFirstName]
	,[eCAFLastName]
	,[StateID]
	,[PhoneNumber]
	,[Extension]
	,[ExternalIDNumber]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkApplicationUser]
	,[UserName]
	,[FirstName]
	,[LastName]
	,[Password]
	,[fkDepartment]
	,[WorkerNumber]
	,[LDAPUser]
	,[LDAPUniqueID]
	,[CountyCode]
	,[MiddleName]
	,[eMail]
	,[IsCaseworker]
	,[IsActive]
	,[eCAFFirstName]
	,[eCAFLastName]
	,[StateID]
	,[PhoneNumber]
	,[Extension]
	,[ExternalIDNumber]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table tracks all Pilot users (including caseworkers), their passwords, and their contact information.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'pkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Username used to log into Pilot', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'UserName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User''s first name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'FirstName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User''s last name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'LastName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User''s (hashed) password', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'Password';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the department table (indicating the user''s primary department)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'fkDepartment';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Worker ID number for the agency', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'WorkerNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LDAP (AD) User Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'LDAPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LDAP (AD) SSID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'LDAPUniqueID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'County that the user works in', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'CountyCode';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User''s middle name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'MiddleName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User''s e-mail address', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'eMail';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Boolean (1 = caseworker)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'IsCaseworker';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Boolean (1=active). May be used to implement "virtual delete" to remove access while keeping user''s history.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'IsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User''s first name, in eCAF', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'eCAFFirstName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User''s last name, in eCAF', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'eCAFLastName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'State ID number for the user', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'StateID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User''s phone number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'PhoneNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Phone number extension', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'Extension';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Optional value to indicate a user''s identifier in an external database', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUser', @level2type = N'COLUMN', @level2name = N'ExternalIDNumber';

