CREATE TABLE [dbo].[JoinApplicationUserDepartment] (
    [pkJoinApplicationUserDepartment] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]               DECIMAL (18) NOT NULL,
    [fkDepartment]                    DECIMAL (18) NOT NULL,
    [LUPUser]                         VARCHAR (50) NULL,
    [LUPDate]                         DATETIME     NULL,
    [CreateUser]                      VARCHAR (50) NULL,
    [CreateDate]                      DATETIME     NULL,
    CONSTRAINT [PK_JoinApplicationUserDepartment] PRIMARY KEY CLUSTERED ([pkJoinApplicationUserDepartment] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[JoinApplicationUserDepartment]([fkApplicationUser] ASC)
    INCLUDE([fkDepartment]);


GO
CREATE NONCLUSTERED INDEX [fkDepartment]
    ON [dbo].[JoinApplicationUserDepartment]([fkDepartment] ASC)
    INCLUDE([fkApplicationUser]);


GO
CREATE Trigger [dbo].[tr_JoinApplicationUserDepartmentAudit_d] On [dbo].[JoinApplicationUserDepartment]
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
From JoinApplicationUserDepartmentAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinApplicationUserDepartment] = d.[pkJoinApplicationUserDepartment]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinApplicationUserDepartmentAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinApplicationUserDepartment]
	,[fkApplicationUser]
	,[fkDepartment]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinApplicationUserDepartment]
	,[fkApplicationUser]
	,[fkDepartment]
From  Deleted
GO
CREATE Trigger [dbo].[tr_JoinApplicationUserDepartmentAudit_UI] On [dbo].[JoinApplicationUserDepartment]
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

Update JoinApplicationUserDepartment
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinApplicationUserDepartment dbTable
	Inner Join Inserted i on dbtable.pkJoinApplicationUserDepartment = i.pkJoinApplicationUserDepartment
	Left Join Deleted d on d.pkJoinApplicationUserDepartment = d.pkJoinApplicationUserDepartment
	Where d.pkJoinApplicationUserDepartment is null

Update JoinApplicationUserDepartment
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinApplicationUserDepartment dbTable
	Inner Join Deleted d on dbTable.pkJoinApplicationUserDepartment = d.pkJoinApplicationUserDepartment
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinApplicationUserDepartmentAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinApplicationUserDepartment] = i.[pkJoinApplicationUserDepartment]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinApplicationUserDepartmentAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinApplicationUserDepartment]
	,[fkApplicationUser]
	,[fkDepartment]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinApplicationUserDepartment]
	,[fkApplicationUser]
	,[fkDepartment]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated – This join table represents the relationship between ApplicationUser and Department.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserDepartment';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserDepartment', @level2type = N'COLUMN', @level2name = N'pkJoinApplicationUserDepartment';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Application user', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserDepartment', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Department', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserDepartment', @level2type = N'COLUMN', @level2name = N'fkDepartment';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserDepartment', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserDepartment', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserDepartment', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserDepartment', @level2type = N'COLUMN', @level2name = N'CreateDate';

