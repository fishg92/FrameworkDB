CREATE TABLE [dbo].[ApplicationUserDefaultRoleAssignment] (
    [pkApplicationUserDefaultRoleAssignment] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]                      DECIMAL (18) NOT NULL,
    [fkDefaultRole]                          DECIMAL (18) NOT NULL,
    [LUPUser]                                VARCHAR (50) NULL,
    [LUPDate]                                DATETIME     NULL,
    [CreateUser]                             VARCHAR (50) NULL,
    [CreateDate]                             DATETIME     NULL,
    CONSTRAINT [PK_ApplicationUserDefaultRoleAssignment] PRIMARY KEY CLUSTERED ([pkApplicationUserDefaultRoleAssignment] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[ApplicationUserDefaultRoleAssignment]([fkApplicationUser] ASC)
    INCLUDE([fkDefaultRole]);


GO
CREATE NONCLUSTERED INDEX [fkDefaultRole]
    ON [dbo].[ApplicationUserDefaultRoleAssignment]([fkDefaultRole] ASC)
    INCLUDE([fkApplicationUser]);


GO
CREATE Trigger [dbo].[tr_ApplicationUserDefaultRoleAssignmentAudit_d] On [dbo].[ApplicationUserDefaultRoleAssignment]
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
From ApplicationUserDefaultRoleAssignmentAudit dbTable
Inner Join deleted d ON dbTable.[pkApplicationUserDefaultRoleAssignment] = d.[pkApplicationUserDefaultRoleAssignment]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ApplicationUserDefaultRoleAssignmentAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkApplicationUserDefaultRoleAssignment]
	,[fkApplicationUser]
	,[fkDefaultRole]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkApplicationUserDefaultRoleAssignment]
	,[fkApplicationUser]
	,[fkDefaultRole]
From  Deleted
GO
CREATE Trigger [dbo].[tr_ApplicationUserDefaultRoleAssignmentAudit_UI] On [dbo].[ApplicationUserDefaultRoleAssignment]
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

Update ApplicationUserDefaultRoleAssignment
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ApplicationUserDefaultRoleAssignment dbTable
	Inner Join Inserted i on dbtable.pkApplicationUserDefaultRoleAssignment = i.pkApplicationUserDefaultRoleAssignment
	Left Join Deleted d on d.pkApplicationUserDefaultRoleAssignment = d.pkApplicationUserDefaultRoleAssignment
	Where d.pkApplicationUserDefaultRoleAssignment is null

Update ApplicationUserDefaultRoleAssignment
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ApplicationUserDefaultRoleAssignment dbTable
	Inner Join Deleted d on dbTable.pkApplicationUserDefaultRoleAssignment = d.pkApplicationUserDefaultRoleAssignment
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From ApplicationUserDefaultRoleAssignmentAudit dbTable
Inner Join inserted i ON dbTable.[pkApplicationUserDefaultRoleAssignment] = i.[pkApplicationUserDefaultRoleAssignment]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ApplicationUserDefaultRoleAssignmentAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkApplicationUserDefaultRoleAssignment]
	,[fkApplicationUser]
	,[fkDefaultRole]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkApplicationUserDefaultRoleAssignment]
	,[fkApplicationUser]
	,[fkDefaultRole]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Depricated - table containing role assignments by user (now use JoinApplicationUserrefRole)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserDefaultRoleAssignment';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, self-incrementing ID as primary key
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserDefaultRoleAssignment', @level2type = N'COLUMN', @level2name = N'pkApplicationUserDefaultRoleAssignment';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserDefaultRoleAssignment', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Default Role', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserDefaultRoleAssignment', @level2type = N'COLUMN', @level2name = N'fkDefaultRole';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserDefaultRoleAssignment', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserDefaultRoleAssignment', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserDefaultRoleAssignment', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'eAuditing information: Create Dat', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserDefaultRoleAssignment', @level2type = N'COLUMN', @level2name = N'CreateDate';

