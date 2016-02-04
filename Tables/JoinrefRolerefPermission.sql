CREATE TABLE [dbo].[JoinrefRolerefPermission] (
    [pkJoinrefRolerefPermission] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkrefRole]                  DECIMAL (18) NOT NULL,
    [fkrefPermission]            DECIMAL (18) NOT NULL,
    [LUPUser]                    VARCHAR (50) NULL,
    [LUPDate]                    DATETIME     NULL,
    [CreateUser]                 VARCHAR (50) NULL,
    [CreateDate]                 DATETIME     NULL,
    CONSTRAINT [PK_JoinrefRolerefPermission] PRIMARY KEY CLUSTERED ([pkJoinrefRolerefPermission] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkrefPermission_fkrefRole]
    ON [dbo].[JoinrefRolerefPermission]([fkrefPermission] ASC, [fkrefRole] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkrefRole_fkrefPermission]
    ON [dbo].[JoinrefRolerefPermission]([fkrefRole] ASC, [fkrefPermission] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_JoinrefRolerefPermissionAudit_d] On [dbo].[JoinrefRolerefPermission]
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
From JoinrefRolerefPermissionAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinrefRolerefPermission] = d.[pkJoinrefRolerefPermission]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinrefRolerefPermissionAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinrefRolerefPermission]
	,[fkrefRole]
	,[fkrefPermission]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinrefRolerefPermission]
	,[fkrefRole]
	,[fkrefPermission]
From  Deleted
GO
CREATE Trigger [dbo].[tr_JoinrefRolerefPermissionAudit_UI] On [dbo].[JoinrefRolerefPermission]
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

Update JoinrefRolerefPermission
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinrefRolerefPermission dbTable
	Inner Join Inserted i on dbtable.pkJoinrefRolerefPermission = i.pkJoinrefRolerefPermission
	Left Join Deleted d on d.pkJoinrefRolerefPermission = d.pkJoinrefRolerefPermission
	Where d.pkJoinrefRolerefPermission is null

Update JoinrefRolerefPermission
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinrefRolerefPermission dbTable
	Inner Join Deleted d on dbTable.pkJoinrefRolerefPermission = d.pkJoinrefRolerefPermission
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinrefRolerefPermissionAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinrefRolerefPermission] = i.[pkJoinrefRolerefPermission]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinrefRolerefPermissionAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinrefRolerefPermission]
	,[fkrefRole]
	,[fkrefPermission]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinrefRolerefPermission]
	,[fkrefRole]
	,[fkrefPermission]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table joins roles to permissions.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefRolerefPermission';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefRolerefPermission', @level2type = N'COLUMN', @level2name = N'pkJoinrefRolerefPermission';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the refRole table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefRolerefPermission', @level2type = N'COLUMN', @level2name = N'fkrefRole';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the refPermission table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefRolerefPermission', @level2type = N'COLUMN', @level2name = N'fkrefPermission';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefRolerefPermission', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefRolerefPermission', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefRolerefPermission', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinrefRolerefPermission', @level2type = N'COLUMN', @level2name = N'CreateDate';

