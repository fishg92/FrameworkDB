CREATE TABLE [dbo].[JoinApplicationUserProgramType] (
    [pkJoinApplicationUserProgramType] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]                DECIMAL (18) NOT NULL,
    [fkProgramType]                    DECIMAL (18) NOT NULL,
    [LUPUser]                          VARCHAR (50) NULL,
    [LUPDate]                          DATETIME     NULL,
    [CreateUser]                       VARCHAR (50) NULL,
    [CreateDate]                       DATETIME     NULL,
    CONSTRAINT [PK_JoinApplicationUserProgramType] PRIMARY KEY CLUSTERED ([pkJoinApplicationUserProgramType] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[JoinApplicationUserProgramType]([fkApplicationUser] ASC)
    INCLUDE([fkProgramType]);


GO
CREATE NONCLUSTERED INDEX [fkProgramType]
    ON [dbo].[JoinApplicationUserProgramType]([fkProgramType] ASC)
    INCLUDE([fkApplicationUser]);


GO
CREATE Trigger [dbo].[tr_JoinApplicationUserProgramTypeAudit_UI] On [dbo].[JoinApplicationUserProgramType]
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

Update JoinApplicationUserProgramType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinApplicationUserProgramType dbTable
	Inner Join Inserted i on dbtable.pkJoinApplicationUserProgramType = i.pkJoinApplicationUserProgramType
	Left Join Deleted d on d.pkJoinApplicationUserProgramType = d.pkJoinApplicationUserProgramType
	Where d.pkJoinApplicationUserProgramType is null

Update JoinApplicationUserProgramType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinApplicationUserProgramType dbTable
	Inner Join Deleted d on dbTable.pkJoinApplicationUserProgramType = d.pkJoinApplicationUserProgramType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinApplicationUserProgramTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinApplicationUserProgramType] = i.[pkJoinApplicationUserProgramType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinApplicationUserProgramTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinApplicationUserProgramType]
	,[fkApplicationUser]
	,[fkProgramType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinApplicationUserProgramType]
	,[fkApplicationUser]
	,[fkProgramType]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinApplicationUserProgramTypeAudit_d] On [dbo].[JoinApplicationUserProgramType]
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
From JoinApplicationUserProgramTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinApplicationUserProgramType] = d.[pkJoinApplicationUserProgramType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinApplicationUserProgramTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinApplicationUserProgramType]
	,[fkApplicationUser]
	,[fkProgramType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinApplicationUserProgramType]
	,[fkApplicationUser]
	,[fkProgramType]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This join table represents the relationship between ApplicationUser and ProgramType.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserProgramType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserProgramType', @level2type = N'COLUMN', @level2name = N'pkJoinApplicationUserProgramType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserProgramType', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ProgramType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserProgramType', @level2type = N'COLUMN', @level2name = N'fkProgramType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserProgramType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserProgramType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserProgramType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserProgramType', @level2type = N'COLUMN', @level2name = N'CreateDate';

