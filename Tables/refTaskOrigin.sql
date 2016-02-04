CREATE TABLE [dbo].[refTaskOrigin] (
    [pkrefTaskOrigin] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [TaskOriginName]  VARCHAR (150) NOT NULL,
    [Active]          BIT           CONSTRAINT [DF_TaskOrigin_Active] DEFAULT ('True') NOT NULL,
    CONSTRAINT [PK_TaskOrigins] PRIMARY KEY CLUSTERED ([pkrefTaskOrigin] ASC)
);


GO
CREATE Trigger [dbo].[tr_refTaskOriginAudit_UI] On [dbo].[refTaskOrigin]
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
From refTaskOriginAudit dbTable
Inner Join inserted i ON dbTable.[pkrefTaskOrigin] = i.[pkrefTaskOrigin]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refTaskOriginAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefTaskOrigin]
	,[TaskOriginName]
	,[Active]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkrefTaskOrigin]
	,[TaskOriginName]
	,[Active]

From  Inserted
GO
CREATE Trigger [dbo].[tr_refTaskOriginAudit_d] On [dbo].[refTaskOrigin]
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
From refTaskOriginAudit dbTable
Inner Join deleted d ON dbTable.[pkrefTaskOrigin] = d.[pkrefTaskOrigin]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refTaskOriginAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefTaskOrigin]
	,[TaskOriginName]
	,[Active]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkrefTaskOrigin]
	,[TaskOriginName]
	,[Active]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This reference table lists the different ways that a task can be created within the system. For example, tasks might be created through a client phone call or from a scanned document.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskOrigin';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskOrigin', @level2type = N'COLUMN', @level2name = N'pkrefTaskOrigin';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What created the task (e.g. a client phone call, a scanned document, etc.)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskOrigin', @level2type = N'COLUMN', @level2name = N'TaskOriginName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is this task origin still used in the system (1=yes)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskOrigin', @level2type = N'COLUMN', @level2name = N'Active';

