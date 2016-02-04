CREATE TABLE [dbo].[EventType] (
    [pkEventType]            DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [Description]            VARCHAR (250) NULL,
    [fkProgramType]          DECIMAL (18)  NULL,
    [fkSmartView]            DECIMAL (18)  NULL,
    [IncludeCaseworkerCases] BIT           NULL,
    [IncludeFavoriteCases]   BIT           NULL,
    CONSTRAINT [PK_EventType] PRIMARY KEY CLUSTERED ([pkEventType] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkProgramType]
    ON [dbo].[EventType]([fkProgramType] ASC);


GO
CREATE NONCLUSTERED INDEX [fkSmartView]
    ON [dbo].[EventType]([fkSmartView] ASC);


GO
CREATE Trigger [dbo].[tr_EventTypeAudit_UI] On [dbo].[EventType]
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
From EventTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkEventType] = i.[pkEventType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into EventTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkEventType]
	,[Description]
	,[fkProgramType]
	,[fkSmartView]
	,[IncludeCaseworkerCases]
	,[IncludeFavoriteCases]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkEventType]
	,[Description]
	,[fkProgramType]
	,[fkSmartView]
	,[IncludeCaseworkerCases]
	,[IncludeFavoriteCases]

From  Inserted
GO
CREATE Trigger [dbo].[tr_EventTypeAudit_d] On [dbo].[EventType]
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
From EventTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkEventType] = d.[pkEventType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into EventTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkEventType]
	,[Description]
	,[fkProgramType]
	,[fkSmartView]
	,[IncludeCaseworkerCases]
	,[IncludeFavoriteCases]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkEventType]
	,[Description]
	,[fkProgramType]
	,[fkSmartView]
	,[IncludeCaseworkerCases]
	,[IncludeFavoriteCases]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Types of events defined as part of the Compass Connect sync process', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventType', @level2type = N'COLUMN', @level2name = N'pkEventType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Common description for this event type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventType', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ProgramType table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventType', @level2type = N'COLUMN', @level2name = N'fkProgramType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to SmartView table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventType', @level2type = N'COLUMN', @level2name = N'fkSmartView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Are case worker''s cases included for this event?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventType', @level2type = N'COLUMN', @level2name = N'IncludeCaseworkerCases';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Are favorite cases included for this event?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'EventType', @level2type = N'COLUMN', @level2name = N'IncludeFavoriteCases';

