CREATE TABLE [dbo].[refTaskTypeEscalation] (
    [pkrefTaskTypeEscalation] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkrefTaskType]           DECIMAL (18) NOT NULL,
    [Sequence]                INT          NOT NULL,
    [MinutesAfterDueDate]     INT          NOT NULL,
    [LUPUser]                 VARCHAR (50) NULL,
    [LUPDate]                 DATETIME     NULL,
    [CreateUser]              VARCHAR (50) NULL,
    [CreateDate]              DATETIME     NULL,
    CONSTRAINT [PK_refTaskTypeEscalation] PRIMARY KEY CLUSTERED ([pkrefTaskTypeEscalation] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkrefTaskType]
    ON [dbo].[refTaskTypeEscalation]([fkrefTaskType] ASC);


GO
CREATE Trigger [dbo].[tr_refTaskTypeEscalationAudit_UI] On [dbo].[refTaskTypeEscalation]
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

Update refTaskTypeEscalation
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refTaskTypeEscalation dbTable
	Inner Join Inserted i on dbtable.pkrefTaskTypeEscalation = i.pkrefTaskTypeEscalation
	Left Join Deleted d on d.pkrefTaskTypeEscalation = d.pkrefTaskTypeEscalation
	Where d.pkrefTaskTypeEscalation is null

Update refTaskTypeEscalation
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refTaskTypeEscalation dbTable
	Inner Join Deleted d on dbTable.pkrefTaskTypeEscalation = d.pkrefTaskTypeEscalation
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From refTaskTypeEscalationAudit dbTable
Inner Join inserted i ON dbTable.[pkrefTaskTypeEscalation] = i.[pkrefTaskTypeEscalation]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refTaskTypeEscalationAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefTaskTypeEscalation]
	,[fkrefTaskType]
	,[Sequence]
	,[MinutesAfterDueDate]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkrefTaskTypeEscalation]
	,[fkrefTaskType]
	,[Sequence]
	,[MinutesAfterDueDate]

From  Inserted
GO
CREATE Trigger [dbo].[tr_refTaskTypeEscalationAudit_d] On [dbo].[refTaskTypeEscalation]
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
From refTaskTypeEscalationAudit dbTable
Inner Join deleted d ON dbTable.[pkrefTaskTypeEscalation] = d.[pkrefTaskTypeEscalation]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refTaskTypeEscalationAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefTaskTypeEscalation]
	,[fkrefTaskType]
	,[Sequence]
	,[MinutesAfterDueDate]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkrefTaskTypeEscalation]
	,[fkrefTaskType]
	,[Sequence]
	,[MinutesAfterDueDate]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This reference table sets up the escalation scheme for tasks based on their overdue status.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskTypeEscalation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskTypeEscalation', @level2type = N'COLUMN', @level2name = N'pkrefTaskTypeEscalation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to refTaskType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskTypeEscalation', @level2type = N'COLUMN', @level2name = N'fkrefTaskType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ordering information', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskTypeEscalation', @level2type = N'COLUMN', @level2name = N'Sequence';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'How long after the due date is allowed before escalation', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskTypeEscalation', @level2type = N'COLUMN', @level2name = N'MinutesAfterDueDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskTypeEscalation', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskTypeEscalation', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskTypeEscalation', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskTypeEscalation', @level2type = N'COLUMN', @level2name = N'CreateDate';

