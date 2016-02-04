CREATE TABLE [dbo].[refTaskAssignmentReason] (
    [pkrefTaskAssignmentReason] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkrefTaskAssignmentStatus] DECIMAL (18) NOT NULL,
    [Description]               VARCHAR (50) NULL,
    [Active]                    BIT          NULL,
    CONSTRAINT [PK_refTaskAssignmentReason] PRIMARY KEY CLUSTERED ([pkrefTaskAssignmentReason] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkrefTaskAssignmentStatus]
    ON [dbo].[refTaskAssignmentReason]([fkrefTaskAssignmentStatus] ASC);


GO
CREATE Trigger [dbo].[tr_refTaskAssignmentReasonAudit_UI] On [dbo].[refTaskAssignmentReason]
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


--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From refTaskAssignmentReasonAudit dbTable
Inner Join inserted i ON dbTable.[pkrefTaskAssignmentReason] = i.[pkrefTaskAssignmentReason]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refTaskAssignmentReasonAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefTaskAssignmentReason]
	,[fkrefTaskAssignmentStatus]
	,[Description]
	,[Active]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkrefTaskAssignmentReason]
	,[fkrefTaskAssignmentStatus]
	,[Description]
	,[Active]

From  Inserted
GO
CREATE Trigger [dbo].[tr_refTaskAssignmentReasonAudit_d] On [dbo].[refTaskAssignmentReason]
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
From refTaskAssignmentReasonAudit dbTable
Inner Join deleted d ON dbTable.[pkrefTaskAssignmentReason] = d.[pkrefTaskAssignmentReason]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refTaskAssignmentReasonAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefTaskAssignmentReason]
	,[fkrefTaskAssignmentStatus]
	,[Description]
	,[Active]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkrefTaskAssignmentReason]
	,[fkrefTaskAssignmentStatus]
	,[Description]
	,[Active]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This reference table is a reference for the different reasons that a task might be assigned.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskAssignmentReason';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskAssignmentReason', @level2type = N'COLUMN', @level2name = N'pkrefTaskAssignmentReason';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key reference to Task Assignment Status', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskAssignmentReason', @level2type = N'COLUMN', @level2name = N'fkrefTaskAssignmentStatus';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description that explains why the task was assigned', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskAssignmentReason', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is the task currently in use (1=yes)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskAssignmentReason', @level2type = N'COLUMN', @level2name = N'Active';

