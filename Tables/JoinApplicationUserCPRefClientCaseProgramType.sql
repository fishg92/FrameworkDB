CREATE TABLE [dbo].[JoinApplicationUserCPRefClientCaseProgramType] (
    [pkJoinApplicationUserCPRefClientCaseProgramType] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]                               DECIMAL (18) NOT NULL,
    [fkCPRefClientCaseProgramType]                    DECIMAL (18) NOT NULL,
    [LUPUser]                                         VARCHAR (50) NULL,
    [LUPDate]                                         DATETIME     NULL,
    [CreateUser]                                      VARCHAR (50) NULL,
    [CreateDate]                                      DATETIME     NULL,
    CONSTRAINT [PK_JoinApplicationUserCPRefClientCaseProgramType] PRIMARY KEY CLUSTERED ([pkJoinApplicationUserCPRefClientCaseProgramType] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[JoinApplicationUserCPRefClientCaseProgramType]([fkApplicationUser] ASC)
    INCLUDE([fkCPRefClientCaseProgramType]);


GO
CREATE NONCLUSTERED INDEX [fkCPRefClientCaseProgramType]
    ON [dbo].[JoinApplicationUserCPRefClientCaseProgramType]([fkCPRefClientCaseProgramType] ASC)
    INCLUDE([fkApplicationUser]);


GO
CREATE Trigger [dbo].[tr_JoinApplicationUserCPRefClientCaseProgramTypeAudit_d] On [dbo].[JoinApplicationUserCPRefClientCaseProgramType]
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
From JoinApplicationUserCPRefClientCaseProgramTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinApplicationUserCPRefClientCaseProgramType] = d.[pkJoinApplicationUserCPRefClientCaseProgramType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinApplicationUserCPRefClientCaseProgramTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinApplicationUserCPRefClientCaseProgramType]
	,[fkApplicationUser]
	,[fkCPRefClientCaseProgramType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinApplicationUserCPRefClientCaseProgramType]
	,[fkApplicationUser]
	,[fkCPRefClientCaseProgramType]
From  Deleted
GO
CREATE Trigger [dbo].[tr_JoinApplicationUserCPRefClientCaseProgramTypeAudit_UI] On [dbo].[JoinApplicationUserCPRefClientCaseProgramType]
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

Update JoinApplicationUserCPRefClientCaseProgramType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinApplicationUserCPRefClientCaseProgramType dbTable
	Inner Join Inserted i on dbtable.pkJoinApplicationUserCPRefClientCaseProgramType = i.pkJoinApplicationUserCPRefClientCaseProgramType
	Left Join Deleted d on d.pkJoinApplicationUserCPRefClientCaseProgramType = d.pkJoinApplicationUserCPRefClientCaseProgramType
	Where d.pkJoinApplicationUserCPRefClientCaseProgramType is null

Update JoinApplicationUserCPRefClientCaseProgramType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinApplicationUserCPRefClientCaseProgramType dbTable
	Inner Join Deleted d on dbTable.pkJoinApplicationUserCPRefClientCaseProgramType = d.pkJoinApplicationUserCPRefClientCaseProgramType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinApplicationUserCPRefClientCaseProgramTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinApplicationUserCPRefClientCaseProgramType] = i.[pkJoinApplicationUserCPRefClientCaseProgramType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinApplicationUserCPRefClientCaseProgramTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinApplicationUserCPRefClientCaseProgramType]
	,[fkApplicationUser]
	,[fkCPRefClientCaseProgramType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinApplicationUserCPRefClientCaseProgramType]
	,[fkApplicationUser]
	,[fkCPRefClientCaseProgramType]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This join table represents the relationship between ApplicationUser and CPRefClientCaseProgramType.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserCPRefClientCaseProgramType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserCPRefClientCaseProgramType', @level2type = N'COLUMN', @level2name = N'pkJoinApplicationUserCPRefClientCaseProgramType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Application Table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserCPRefClientCaseProgramType', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPRefClientCasePRogramType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserCPRefClientCaseProgramType', @level2type = N'COLUMN', @level2name = N'fkCPRefClientCaseProgramType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserCPRefClientCaseProgramType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserCPRefClientCaseProgramType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserCPRefClientCaseProgramType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserCPRefClientCaseProgramType', @level2type = N'COLUMN', @level2name = N'CreateDate';

