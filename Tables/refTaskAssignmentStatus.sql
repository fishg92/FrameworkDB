CREATE TABLE [dbo].[refTaskAssignmentStatus] (
    [pkrefTaskAssignmentStatus] DECIMAL (18) NOT NULL,
    [Description]               VARCHAR (50) NOT NULL,
    [AssignmentComplete]        BIT          CONSTRAINT [DF_refTaskAssignmentStatus_AssignmentComplete] DEFAULT ((0)) NOT NULL,
    [PropagateTaskStatus]       DECIMAL (18) CONSTRAINT [DF_refTaskAssignmentStatus_PropagateTaskStatus] DEFAULT ((-1)) NOT NULL,
    [LUPUser]                   VARCHAR (50) NULL,
    [LUPDate]                   DATETIME     NULL,
    [CreateUser]                VARCHAR (50) NULL,
    [CreateDate]                DATETIME     NULL,
    CONSTRAINT [PK_refTaskAssignmentStatus] PRIMARY KEY CLUSTERED ([pkrefTaskAssignmentStatus] ASC)
);


GO
CREATE Trigger [dbo].[tr_refTaskAssignmentStatusAudit_d] On [dbo].[refTaskAssignmentStatus]
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
From refTaskAssignmentStatusAudit dbTable
Inner Join deleted d ON dbTable.[pkrefTaskAssignmentStatus] = d.[pkrefTaskAssignmentStatus]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refTaskAssignmentStatusAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefTaskAssignmentStatus]
	,[Description]
	,[AssignmentComplete]
	,[PropagateTaskStatus]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkrefTaskAssignmentStatus]
	,[Description]
	,[AssignmentComplete]
	,[PropagateTaskStatus]
From  Deleted
GO
CREATE Trigger [dbo].[tr_refTaskAssignmentStatusAudit_UI] On [dbo].[refTaskAssignmentStatus]
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

Update refTaskAssignmentStatus
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refTaskAssignmentStatus dbTable
	Inner Join Inserted i on dbtable.pkrefTaskAssignmentStatus = i.pkrefTaskAssignmentStatus
	Left Join Deleted d on d.pkrefTaskAssignmentStatus = d.pkrefTaskAssignmentStatus
	Where d.pkrefTaskAssignmentStatus is null

Update refTaskAssignmentStatus
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refTaskAssignmentStatus dbTable
	Inner Join Deleted d on dbTable.pkrefTaskAssignmentStatus = d.pkrefTaskAssignmentStatus
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From refTaskAssignmentStatusAudit dbTable
Inner Join inserted i ON dbTable.[pkrefTaskAssignmentStatus] = i.[pkrefTaskAssignmentStatus]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refTaskAssignmentStatusAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefTaskAssignmentStatus]
	,[Description]
	,[AssignmentComplete]
	,[PropagateTaskStatus]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkrefTaskAssignmentStatus]
	,[Description]
	,[AssignmentComplete]
	,[PropagateTaskStatus]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This reference table lists the possible status messages for tasks and other information related to their status.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskAssignmentStatus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskAssignmentStatus', @level2type = N'COLUMN', @level2name = N'pkrefTaskAssignmentStatus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the task assignment status (e.g. "Completed")', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskAssignmentStatus', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is the assignment complete? (1=yes). ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskAssignmentStatus', @level2type = N'COLUMN', @level2name = N'AssignmentComplete';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Should the task status be passed on if the task gets reassigned', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskAssignmentStatus', @level2type = N'COLUMN', @level2name = N'PropagateTaskStatus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskAssignmentStatus', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskAssignmentStatus', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskAssignmentStatus', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskAssignmentStatus', @level2type = N'COLUMN', @level2name = N'CreateDate';

