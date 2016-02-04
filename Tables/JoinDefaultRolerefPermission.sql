CREATE TABLE [dbo].[JoinDefaultRolerefPermission] (
    [pkJoinDefaultRolerefPermission] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkDefaultRole]                  DECIMAL (18) NOT NULL,
    [fkrefPermission]                DECIMAL (18) NOT NULL,
    [LUPUser]                        VARCHAR (50) NULL,
    [LUPDate]                        DATETIME     NULL,
    [CreateUser]                     VARCHAR (50) NULL,
    [CreateDate]                     DATETIME     NULL,
    CONSTRAINT [PK_JoinDefaultRolerefPermission] PRIMARY KEY CLUSTERED ([pkJoinDefaultRolerefPermission] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkDefaultRole_fkrefPermission]
    ON [dbo].[JoinDefaultRolerefPermission]([fkDefaultRole] ASC, [fkrefPermission] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkrefPermission_fkDefaultRole]
    ON [dbo].[JoinDefaultRolerefPermission]([fkrefPermission] ASC, [fkDefaultRole] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_JoinDefaultRolerefPermissionAudit_UI] On [dbo].[JoinDefaultRolerefPermission]
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

Update JoinDefaultRolerefPermission
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinDefaultRolerefPermission dbTable
	Inner Join Inserted i on dbtable.pkJoinDefaultRolerefPermission = i.pkJoinDefaultRolerefPermission
	Left Join Deleted d on d.pkJoinDefaultRolerefPermission = d.pkJoinDefaultRolerefPermission
	Where d.pkJoinDefaultRolerefPermission is null

Update JoinDefaultRolerefPermission
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinDefaultRolerefPermission dbTable
	Inner Join Deleted d on dbTable.pkJoinDefaultRolerefPermission = d.pkJoinDefaultRolerefPermission
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinDefaultRolerefPermissionAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinDefaultRolerefPermission] = i.[pkJoinDefaultRolerefPermission]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinDefaultRolerefPermissionAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinDefaultRolerefPermission]
	,[fkDefaultRole]
	,[fkrefPermission]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinDefaultRolerefPermission]
	,[fkDefaultRole]
	,[fkrefPermission]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinDefaultRolerefPermissionAudit_d] On [dbo].[JoinDefaultRolerefPermission]
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
From JoinDefaultRolerefPermissionAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinDefaultRolerefPermission] = d.[pkJoinDefaultRolerefPermission]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinDefaultRolerefPermissionAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinDefaultRolerefPermission]
	,[fkDefaultRole]
	,[fkrefPermission]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinDefaultRolerefPermission]
	,[fkDefaultRole]
	,[fkrefPermission]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table seems to be deprecated. ApplicationUserDefaultRoleAssignment IS deprecated, and I suspect that the default role table is as well. In any case, in none of the Northwoods environments is there any data in this table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinDefaultRolerefPermission';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinDefaultRolerefPermission', @level2type = N'COLUMN', @level2name = N'pkJoinDefaultRolerefPermission';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to defaultRole', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinDefaultRolerefPermission', @level2type = N'COLUMN', @level2name = N'fkDefaultRole';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to refPermission', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinDefaultRolerefPermission', @level2type = N'COLUMN', @level2name = N'fkrefPermission';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinDefaultRolerefPermission', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinDefaultRolerefPermission', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinDefaultRolerefPermission', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinDefaultRolerefPermission', @level2type = N'COLUMN', @level2name = N'CreateDate';

