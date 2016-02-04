CREATE TABLE [dbo].[JoinTaskCPClientCase] (
    [pkJoinTaskCPClientCase] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPClientCase]         DECIMAL (18) NOT NULL,
    [fkTask]                 DECIMAL (18) NOT NULL,
    [LUPUser]                VARCHAR (50) NULL,
    [LUPDate]                DATETIME     NULL,
    [CreateUser]             VARCHAR (50) NULL,
    [CreateDate]             DATETIME     NULL,
    CONSTRAINT [PK_JoinTaskCPClientCase] PRIMARY KEY CLUSTERED ([pkJoinTaskCPClientCase] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkTask_fkCPClientCase]
    ON [dbo].[JoinTaskCPClientCase]([fkTask] ASC, [fkCPClientCase] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [fkCPClientCase_fkTask]
    ON [dbo].[JoinTaskCPClientCase]([fkCPClientCase] ASC, [fkTask] ASC);


GO
CREATE Trigger [dbo].[tr_JoinTaskCPClientCaseAudit_UI] On [dbo].[JoinTaskCPClientCase]
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

Update JoinTaskCPClientCase
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinTaskCPClientCase dbTable
	Inner Join Inserted i on dbtable.pkJoinTaskCPClientCase = i.pkJoinTaskCPClientCase
	Left Join Deleted d on d.pkJoinTaskCPClientCase = d.pkJoinTaskCPClientCase
	Where d.pkJoinTaskCPClientCase is null

Update JoinTaskCPClientCase
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinTaskCPClientCase dbTable
	Inner Join Deleted d on dbTable.pkJoinTaskCPClientCase = d.pkJoinTaskCPClientCase
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinTaskCPClientCaseAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinTaskCPClientCase] = i.[pkJoinTaskCPClientCase]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinTaskCPClientCaseAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinTaskCPClientCase]
	,[fkCPClientCase]
	,[fkTask]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinTaskCPClientCase]
	,[fkCPClientCase]
	,[fkTask]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinTaskCPClientCaseAudit_d] On [dbo].[JoinTaskCPClientCase]
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
From JoinTaskCPClientCaseAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinTaskCPClientCase] = d.[pkJoinTaskCPClientCase]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinTaskCPClientCaseAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinTaskCPClientCase]
	,[fkCPClientCase]
	,[fkTask]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinTaskCPClientCase]
	,[fkCPClientCase]
	,[fkTask]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This join table links tasks with cases in Compass People.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClientCase';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClientCase', @level2type = N'COLUMN', @level2name = N'pkJoinTaskCPClientCase';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPClientCase', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClientCase', @level2type = N'COLUMN', @level2name = N'fkCPClientCase';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Task', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClientCase', @level2type = N'COLUMN', @level2name = N'fkTask';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClientCase', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClientCase', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClientCase', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClientCase', @level2type = N'COLUMN', @level2name = N'CreateDate';

