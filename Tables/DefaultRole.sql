CREATE TABLE [dbo].[DefaultRole] (
    [pkDefaultRole] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [RoleName]      VARCHAR (50)  NOT NULL,
    [Description]   VARCHAR (100) NULL,
    [LUPUser]       VARCHAR (50)  NULL,
    [LUPDate]       DATETIME      NULL,
    [CreateUser]    VARCHAR (50)  NULL,
    [CreateDate]    DATETIME      NULL,
    CONSTRAINT [PK_DefaultRoles] PRIMARY KEY CLUSTERED ([pkDefaultRole] ASC)
);


GO
CREATE Trigger [dbo].[tr_DefaultRoleAudit_d] On [dbo].[DefaultRole]
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
From DefaultRoleAudit dbTable
Inner Join deleted d ON dbTable.[pkDefaultRole] = d.[pkDefaultRole]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into DefaultRoleAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkDefaultRole]
	,[RoleName]
	,[Description]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkDefaultRole]
	,[RoleName]
	,[Description]
From  Deleted
GO
CREATE Trigger [dbo].[tr_DefaultRoleAudit_UI] On [dbo].[DefaultRole]
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

Update DefaultRole
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From DefaultRole dbTable
	Inner Join Inserted i on dbtable.pkDefaultRole = i.pkDefaultRole
	Left Join Deleted d on d.pkDefaultRole = d.pkDefaultRole
	Where d.pkDefaultRole is null

Update DefaultRole
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From DefaultRole dbTable
	Inner Join Deleted d on dbTable.pkDefaultRole = d.pkDefaultRole
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From DefaultRoleAudit dbTable
Inner Join inserted i ON dbTable.[pkDefaultRole] = i.[pkDefaultRole]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into DefaultRoleAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkDefaultRole]
	,[RoleName]
	,[Description]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkDefaultRole]
	,[RoleName]
	,[Description]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default role assignment table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DefaultRole';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, auto-incrementing system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DefaultRole', @level2type = N'COLUMN', @level2name = N'pkDefaultRole';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Brief label for the role', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DefaultRole', @level2type = N'COLUMN', @level2name = N'RoleName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Long description of the role', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DefaultRole', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DefaultRole', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DefaultRole', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DefaultRole', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DefaultRole', @level2type = N'COLUMN', @level2name = N'CreateDate';

