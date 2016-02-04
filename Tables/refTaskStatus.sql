CREATE TABLE [dbo].[refTaskStatus] (
    [pkrefTaskStatus] DECIMAL (18) NOT NULL,
    [Description]     VARCHAR (50) NOT NULL,
    [TaskComplete]    BIT          CONSTRAINT [DF_refTaskStatus_TaskComplete] DEFAULT ((0)) NOT NULL,
    [LUPUser]         VARCHAR (50) NULL,
    [LUPDate]         DATETIME     NULL,
    [CreateUser]      VARCHAR (50) NULL,
    [CreateDate]      DATETIME     NULL,
    CONSTRAINT [PK_refTaskStatus] PRIMARY KEY CLUSTERED ([pkrefTaskStatus] ASC),
    CONSTRAINT [refTaskStatus_Description] UNIQUE NONCLUSTERED ([Description] ASC)
);


GO
CREATE Trigger [dbo].[tr_refTaskStatusAudit_d] On [dbo].[refTaskStatus]
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
From refTaskStatusAudit dbTable
Inner Join deleted d ON dbTable.[pkrefTaskStatus] = d.[pkrefTaskStatus]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refTaskStatusAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefTaskStatus]
	,[Description]
	,[TaskComplete]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkrefTaskStatus]
	,[Description]
	,[TaskComplete]
From  Deleted
GO
CREATE Trigger [dbo].[tr_refTaskStatusAudit_UI] On [dbo].[refTaskStatus]
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

Update refTaskStatus
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refTaskStatus dbTable
	Inner Join Inserted i on dbtable.pkrefTaskStatus = i.pkrefTaskStatus
	Left Join Deleted d on d.pkrefTaskStatus = d.pkrefTaskStatus
	Where d.pkrefTaskStatus is null

Update refTaskStatus
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refTaskStatus dbTable
	Inner Join Deleted d on dbTable.pkrefTaskStatus = d.pkrefTaskStatus
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From refTaskStatusAudit dbTable
Inner Join inserted i ON dbTable.[pkrefTaskStatus] = i.[pkrefTaskStatus]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refTaskStatusAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefTaskStatus]
	,[Description]
	,[TaskComplete]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkrefTaskStatus]
	,[Description]
	,[TaskComplete]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This reference table is a reference list of the different statuses that tasks may be in. They are related to an enumeration in the code and should not be changed without a corresponding PCR.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskStatus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskStatus', @level2type = N'COLUMN', @level2name = N'pkrefTaskStatus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the status', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskStatus', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Whether or not a task in this status should be considered completed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskStatus', @level2type = N'COLUMN', @level2name = N'TaskComplete';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskStatus', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskStatus', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskStatus', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskStatus', @level2type = N'COLUMN', @level2name = N'CreateDate';

