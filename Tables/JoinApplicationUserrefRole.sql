CREATE TABLE [dbo].[JoinApplicationUserrefRole] (
    [pkJoinApplicationUserrefRole] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]            DECIMAL (18) NOT NULL,
    [fkrefRole]                    DECIMAL (18) NOT NULL,
    [LUPUser]                      VARCHAR (50) NULL,
    [LUPDate]                      DATETIME     NULL,
    [CreateUser]                   VARCHAR (50) NULL,
    [CreateDate]                   DATETIME     NULL,
    CONSTRAINT [PK_JoinApplicationUserrefRole] PRIMARY KEY CLUSTERED ([pkJoinApplicationUserrefRole] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser_fkrefRole]
    ON [dbo].[JoinApplicationUserrefRole]([fkApplicationUser] ASC, [fkrefRole] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkrefRole]
    ON [dbo].[JoinApplicationUserrefRole]([fkrefRole] ASC)
    INCLUDE([fkApplicationUser]);


GO
CREATE Trigger [dbo].[tr_JoinApplicationUserrefRoleAudit_d] On [dbo].[JoinApplicationUserrefRole]
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
From JoinApplicationUserrefRoleAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinApplicationUserrefRole] = d.[pkJoinApplicationUserrefRole]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinApplicationUserrefRoleAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinApplicationUserrefRole]
	,[fkApplicationUser]
	,[fkrefRole]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinApplicationUserrefRole]
	,[fkApplicationUser]
	,[fkrefRole]
From  Deleted
GO
CREATE Trigger [dbo].[tr_JoinApplicationUserrefRoleAudit_UI] On [dbo].[JoinApplicationUserrefRole]
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

Update JoinApplicationUserrefRole
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinApplicationUserrefRole dbTable
	Inner Join Inserted i on dbtable.pkJoinApplicationUserrefRole = i.pkJoinApplicationUserrefRole
	Left Join Deleted d on d.pkJoinApplicationUserrefRole = d.pkJoinApplicationUserrefRole
	Where d.pkJoinApplicationUserrefRole is null

Update JoinApplicationUserrefRole
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinApplicationUserrefRole dbTable
	Inner Join Deleted d on dbTable.pkJoinApplicationUserrefRole = d.pkJoinApplicationUserrefRole
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinApplicationUserrefRoleAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinApplicationUserrefRole] = i.[pkJoinApplicationUserrefRole]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinApplicationUserrefRoleAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinApplicationUserrefRole]
	,[fkApplicationUser]
	,[fkrefRole]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinApplicationUserrefRole]
	,[fkApplicationUser]
	,[fkrefRole]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Join tables represent a many to many relationship between two or more tables. In this case, ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserrefRole';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserrefRole', @level2type = N'COLUMN', @level2name = N'pkJoinApplicationUserrefRole';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the application user table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserrefRole', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the role table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserrefRole', @level2type = N'COLUMN', @level2name = N'fkrefRole';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserrefRole', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserrefRole', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserrefRole', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserrefRole', @level2type = N'COLUMN', @level2name = N'CreateDate';

