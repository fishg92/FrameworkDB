CREATE TABLE [dbo].[JoinApplicationUserSecureGroup] (
    [pkJoinApplicationUserSecureGroup] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]                DECIMAL (18) NULL,
    [fkLockedEntity]                   DECIMAL (18) NULL,
    [LUPUser]                          VARCHAR (50) NULL,
    [LUPDate]                          DATETIME     NULL,
    [CreateUser]                       VARCHAR (50) NULL,
    [CreateDate]                       DATETIME     NULL,
    CONSTRAINT [PK_JoinApplicationUserSecureGroup] PRIMARY KEY CLUSTERED ([pkJoinApplicationUserSecureGroup] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[JoinApplicationUserSecureGroup]([fkApplicationUser] ASC)
    INCLUDE([fkLockedEntity]);


GO
CREATE NONCLUSTERED INDEX [fkLockedEntity]
    ON [dbo].[JoinApplicationUserSecureGroup]([fkLockedEntity] ASC)
    INCLUDE([fkApplicationUser]);


GO
CREATE Trigger [dbo].[tr_JoinApplicationUserSecureGroupAudit_d] On [dbo].[JoinApplicationUserSecureGroup]
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
From JoinApplicationUserSecureGroupAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinApplicationUserSecureGroup] = d.[pkJoinApplicationUserSecureGroup]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinApplicationUserSecureGroupAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinApplicationUserSecureGroup]
	,[fkApplicationUser]
	,[fkLockedEntity]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinApplicationUserSecureGroup]
	,[fkApplicationUser]
	,[fkLockedEntity]
From  Deleted
GO
CREATE Trigger [dbo].[tr_JoinApplicationUserSecureGroupAudit_UI] On [dbo].[JoinApplicationUserSecureGroup]
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

Update JoinApplicationUserSecureGroup
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinApplicationUserSecureGroup dbTable
	Inner Join Inserted i on dbtable.pkJoinApplicationUserSecureGroup = i.pkJoinApplicationUserSecureGroup
	Left Join Deleted d on d.pkJoinApplicationUserSecureGroup = d.pkJoinApplicationUserSecureGroup
	Where d.pkJoinApplicationUserSecureGroup is null

Update JoinApplicationUserSecureGroup
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinApplicationUserSecureGroup dbTable
	Inner Join Deleted d on dbTable.pkJoinApplicationUserSecureGroup = d.pkJoinApplicationUserSecureGroup
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinApplicationUserSecureGroupAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinApplicationUserSecureGroup] = i.[pkJoinApplicationUserSecureGroup]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinApplicationUserSecureGroupAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinApplicationUserSecureGroup]
	,[fkApplicationUser]
	,[fkLockedEntity]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinApplicationUserSecureGroup]
	,[fkApplicationUser]
	,[fkLockedEntity]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Join tables represent a many to many relationship between two or more tables. In this case, it is the ApplicationUser to the LockedEntity table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserSecureGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserSecureGroup', @level2type = N'COLUMN', @level2name = N'pkJoinApplicationUserSecureGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foregin key to ApplicationUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserSecureGroup', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to LockedEntity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserSecureGroup', @level2type = N'COLUMN', @level2name = N'fkLockedEntity';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserSecureGroup', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserSecureGroup', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserSecureGroup', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserSecureGroup', @level2type = N'COLUMN', @level2name = N'CreateDate';

