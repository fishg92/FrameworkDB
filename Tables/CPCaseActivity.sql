CREATE TABLE [dbo].[CPCaseActivity] (
    [pkCPCaseActivity]     DECIMAL (18)  IDENTITY (1000, 1) NOT NULL,
    [fkCPCaseActivityType] DECIMAL (18)  NULL,
    [fkCPClientCase]       DECIMAL (18)  NULL,
    [Description]          VARCHAR (MAX) NULL,
    [fkCPClient]           DECIMAL (18)  NULL,
    [LUPUser]              VARCHAR (50)  NULL,
    [LUPDate]              DATETIME      NULL,
    [CreateUser]           VARCHAR (50)  NULL,
    [CreateDate]           DATETIME      NULL,
    [EffectiveCreateDate]  DATETIME      NULL,
    CONSTRAINT [PK_CPCaseActivity] PRIMARY KEY CLUSTERED ([pkCPCaseActivity] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxfkCPClient]
    ON [dbo].[CPCaseActivity]([fkCPClient] ASC)
    INCLUDE([Description], [fkCPClientCase]);


GO
CREATE NONCLUSTERED INDEX [fkCPCaseActivityType]
    ON [dbo].[CPCaseActivity]([fkCPCaseActivityType] ASC);


GO
CREATE NONCLUSTERED INDEX [idxfkCPClientCase]
    ON [dbo].[CPCaseActivity]([fkCPClientCase] ASC)
    INCLUDE([Description], [fkCPCaseActivityType]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_CPCaseActivityAudit_d] On [dbo].[CPCaseActivity]
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
From CPCaseActivityAudit dbTable
Inner Join deleted d ON dbTable.[pkCPCaseActivity] = d.[pkCPCaseActivity]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPCaseActivityAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPCaseActivity]
	,[fkCPCaseActivityType]
	,[fkCPClientCase]
	,[Description]
	,[fkCPClient]
	,[EffectiveCreateDate]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPCaseActivity]
	,[fkCPCaseActivityType]
	,[fkCPClientCase]
	,[Description]
	,[fkCPClient]
	,[EffectiveCreateDate]
From  Deleted
GO
CREATE Trigger [dbo].[tr_CPCaseActivityAudit_UI] On [dbo].[CPCaseActivity]
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

Update CPCaseActivity
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	,[EffectiveCreateDate] = isnull(i.EffectiveCreateDate, @Date)
	From CPCaseActivity dbTable
	Inner Join Inserted i on dbtable.pkCPCaseActivity = i.pkCPCaseActivity
	Left Join Deleted d on d.pkCPCaseActivity = d.pkCPCaseActivity
	Where d.pkCPCaseActivity is null

Update CPCaseActivity
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPCaseActivity dbTable
	Inner Join Deleted d on dbTable.pkCPCaseActivity = d.pkCPCaseActivity
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPCaseActivityAudit dbTable
Inner Join inserted i ON dbTable.[pkCPCaseActivity] = i.[pkCPCaseActivity]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPCaseActivityAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPCaseActivity]
	,[fkCPCaseActivityType]
	,[fkCPClientCase]
	,[Description]
	,[fkCPClient]
	,[EffectiveCreateDate]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPCaseActivity]
	,[fkCPCaseActivityType]
	,[fkCPClientCase]
	,[Description]
	,[fkCPClient]
	,isnull([EffectiveCreateDate], @Date)

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table logs any changes to a case or case members.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseActivity';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, auto-incrementing system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseActivity', @level2type = N'COLUMN', @level2name = N'pkCPCaseActivity';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPCaseActivityType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseActivity', @level2type = N'COLUMN', @level2name = N'fkCPCaseActivityType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the CPClientCase table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseActivity', @level2type = N'COLUMN', @level2name = N'fkCPClientCase';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseActivity', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the CPClient table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseActivity', @level2type = N'COLUMN', @level2name = N'fkCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseActivity', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseActivity', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseActivity', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseActivity', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Create date independent of physical audit data for tracking creation of case activity outside of Compass Pilot', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseActivity', @level2type = N'COLUMN', @level2name = N'EffectiveCreateDate';

