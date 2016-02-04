CREATE TABLE [dbo].[CPRefImportLogEventType] (
    [pkCPRefImportLogEventType] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [EventType]                 VARCHAR (50) NULL,
    [LUPUser]                   VARCHAR (50) NULL,
    [LUPDate]                   DATETIME     NULL,
    [CreateUser]                VARCHAR (50) NULL,
    [CreateDate]                DATETIME     NULL,
    CONSTRAINT [PK_CPRefImportLogEventType] PRIMARY KEY CLUSTERED ([pkCPRefImportLogEventType] ASC)
);


GO
CREATE Trigger [dbo].[tr_CPRefImportLogEventTypeAudit_d] On [dbo].[CPRefImportLogEventType]
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
From CPRefImportLogEventTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkCPRefImportLogEventType] = d.[pkCPRefImportLogEventType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPRefImportLogEventTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPRefImportLogEventType]
	,[EventType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPRefImportLogEventType]
	,[EventType]
From  Deleted
GO
CREATE Trigger [dbo].[tr_CPRefImportLogEventTypeAudit_UI] On [dbo].[CPRefImportLogEventType]
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

Update CPRefImportLogEventType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPRefImportLogEventType dbTable
	Inner Join Inserted i on dbtable.pkCPRefImportLogEventType = i.pkCPRefImportLogEventType
	Left Join Deleted d on d.pkCPRefImportLogEventType = d.pkCPRefImportLogEventType
	Where d.pkCPRefImportLogEventType is null

Update CPRefImportLogEventType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPRefImportLogEventType dbTable
	Inner Join Deleted d on dbTable.pkCPRefImportLogEventType = d.pkCPRefImportLogEventType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPRefImportLogEventTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkCPRefImportLogEventType] = i.[pkCPRefImportLogEventType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPRefImportLogEventTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPRefImportLogEventType]
	,[EventType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPRefImportLogEventType]
	,[EventType]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Reference table for the log event types.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefImportLogEventType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefImportLogEventType', @level2type = N'COLUMN', @level2name = N'pkCPRefImportLogEventType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the event type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefImportLogEventType', @level2type = N'COLUMN', @level2name = N'EventType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefImportLogEventType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefImportLogEventType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefImportLogEventType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefImportLogEventType', @level2type = N'COLUMN', @level2name = N'CreateDate';

