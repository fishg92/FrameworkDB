CREATE TABLE [dbo].[LogEntryType] (
    [pkLogEntryType] INT          IDENTITY (1, 1) NOT NULL,
    [EntryID]        INT          NULL,
    [EntryName]      VARCHAR (50) NOT NULL,
    [LUPUser]        VARCHAR (50) NULL,
    [LUPDate]        DATETIME     NULL,
    [CreateUser]     VARCHAR (50) NULL,
    [CreateDate]     DATETIME     NULL,
    CONSTRAINT [PK_LogEntryType] PRIMARY KEY CLUSTERED ([pkLogEntryType] ASC)
);


GO
CREATE Trigger [dbo].[tr_LogEntryTypeAudit_UI] On [dbo].[LogEntryType]
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

Update LogEntryType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From LogEntryType dbTable
	Inner Join Inserted i on dbtable.pkLogEntryType = i.pkLogEntryType
	Left Join Deleted d on d.pkLogEntryType = d.pkLogEntryType
	Where d.pkLogEntryType is null

Update LogEntryType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From LogEntryType dbTable
	Inner Join Deleted d on dbTable.pkLogEntryType = d.pkLogEntryType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From LogEntryTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkLogEntryType] = i.[pkLogEntryType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into LogEntryTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkLogEntryType]
	,[EntryID]
	,[EntryName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkLogEntryType]
	,[EntryID]
	,[EntryName]

From  Inserted
GO
CREATE Trigger [dbo].[tr_LogEntryTypeAudit_d] On [dbo].[LogEntryType]
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
From LogEntryTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkLogEntryType] = d.[pkLogEntryType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into LogEntryTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkLogEntryType]
	,[EntryID]
	,[EntryName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkLogEntryType]
	,[EntryID]
	,[EntryName]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table appears to be deprecated. It shows up in one stored procedure, and that stored procedure is only used in a bit of Compass that''s no longer used. ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LogEntryType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID Number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LogEntryType', @level2type = N'COLUMN', @level2name = N'pkLogEntryType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LogEntryType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LogEntryType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LogEntryType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LogEntryType', @level2type = N'COLUMN', @level2name = N'CreateDate';

