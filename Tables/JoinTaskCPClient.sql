CREATE TABLE [dbo].[JoinTaskCPClient] (
    [pkJoinTaskCPClient] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPClient]         DECIMAL (18) NOT NULL,
    [fkTask]             DECIMAL (18) NOT NULL,
    [LUPUser]            VARCHAR (50) NULL,
    [LUPDate]            DATETIME     NULL,
    [CreateUser]         VARCHAR (50) NULL,
    [CreateDate]         DATETIME     NULL,
    CONSTRAINT [PK_JoinTaskCPClient] PRIMARY KEY CLUSTERED ([pkJoinTaskCPClient] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [fkTask_fkCPClient]
    ON [dbo].[JoinTaskCPClient]([fkTask] ASC, [fkCPClient] ASC);


GO
CREATE NONCLUSTERED INDEX [fkCPClient_fkTask]
    ON [dbo].[JoinTaskCPClient]([fkCPClient] ASC, [fkTask] ASC);


GO
CREATE Trigger [dbo].[tr_JoinTaskCPClientAudit_UI] On [dbo].[JoinTaskCPClient]
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

Update JoinTaskCPClient
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinTaskCPClient dbTable
	Inner Join Inserted i on dbtable.pkJoinTaskCPClient = i.pkJoinTaskCPClient
	Left Join Deleted d on d.pkJoinTaskCPClient = d.pkJoinTaskCPClient
	Where d.pkJoinTaskCPClient is null

Update JoinTaskCPClient
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinTaskCPClient dbTable
	Inner Join Deleted d on dbTable.pkJoinTaskCPClient = d.pkJoinTaskCPClient
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinTaskCPClientAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinTaskCPClient] = i.[pkJoinTaskCPClient]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinTaskCPClientAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinTaskCPClient]
	,[fkCPClient]
	,[fkTask]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinTaskCPClient]
	,[fkCPClient]
	,[fkTask]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinTaskCPClientAudit_d] On [dbo].[JoinTaskCPClient]
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
From JoinTaskCPClientAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinTaskCPClient] = d.[pkJoinTaskCPClient]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinTaskCPClientAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinTaskCPClient]
	,[fkCPClient]
	,[fkTask]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinTaskCPClient]
	,[fkCPClient]
	,[fkTask]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This join table links tasks with different clients in Compass People.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClient', @level2type = N'COLUMN', @level2name = N'pkJoinTaskCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPClient', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClient', @level2type = N'COLUMN', @level2name = N'fkCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Task', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClient', @level2type = N'COLUMN', @level2name = N'fkTask';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClient', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClient', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClient', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskCPClient', @level2type = N'COLUMN', @level2name = N'CreateDate';

