CREATE TABLE [dbo].[CPCaseActivityType] (
    [pkCPCaseActivityType] DECIMAL (18)  NOT NULL,
    [Description]          VARCHAR (100) NULL,
    [LUPUser]              VARCHAR (50)  NULL,
    [LUPDate]              DATETIME      NULL,
    [CreateUser]           VARCHAR (50)  NULL,
    [CreateDate]           DATETIME      NULL,
    CONSTRAINT [PK_CPCaseActivityType] PRIMARY KEY CLUSTERED ([pkCPCaseActivityType] ASC)
);


GO
CREATE Trigger [dbo].[tr_CPCaseActivityTypeAudit_d] On [dbo].[CPCaseActivityType]
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
From CPCaseActivityTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkCPCaseActivityType] = d.[pkCPCaseActivityType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPCaseActivityTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPCaseActivityType]
	,[Description]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPCaseActivityType]
	,[Description]
From  Deleted
GO
CREATE Trigger [dbo].[tr_CPCaseActivityTypeAudit_UI] On [dbo].[CPCaseActivityType]
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

Update CPCaseActivityType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPCaseActivityType dbTable
	Inner Join Inserted i on dbtable.pkCPCaseActivityType = i.pkCPCaseActivityType
	Left Join Deleted d on d.pkCPCaseActivityType = d.pkCPCaseActivityType
	Where d.pkCPCaseActivityType is null

Update CPCaseActivityType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPCaseActivityType dbTable
	Inner Join Deleted d on dbTable.pkCPCaseActivityType = d.pkCPCaseActivityType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPCaseActivityTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkCPCaseActivityType] = i.[pkCPCaseActivityType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPCaseActivityTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPCaseActivityType]
	,[Description]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPCaseActivityType]
	,[Description]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains types of activities that can occur for a case (or case members).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseActivityType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, auto-incrementing system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseActivityType', @level2type = N'COLUMN', @level2name = N'pkCPCaseActivityType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Text value to describe the type of activity.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseActivityType', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseActivityType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseActivityType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseActivityType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPCaseActivityType', @level2type = N'COLUMN', @level2name = N'CreateDate';

