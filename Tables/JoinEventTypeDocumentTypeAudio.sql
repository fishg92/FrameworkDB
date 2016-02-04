CREATE TABLE [dbo].[JoinEventTypeDocumentTypeAudio] (
    [pkJoinEventTypeDocumentTypeAudio] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkEventType]                      DECIMAL (18) NULL,
    [fkDocumentType]                   VARCHAR (50) NULL,
    CONSTRAINT [PK_JoinEventTypeDocumentTypeAudio] PRIMARY KEY CLUSTERED ([pkJoinEventTypeDocumentTypeAudio] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkDocumentType]
    ON [dbo].[JoinEventTypeDocumentTypeAudio]([fkDocumentType] ASC)
    INCLUDE([fkEventType]);


GO
CREATE NONCLUSTERED INDEX [fkEventType]
    ON [dbo].[JoinEventTypeDocumentTypeAudio]([fkEventType] ASC)
    INCLUDE([fkDocumentType]);


GO
CREATE Trigger [dbo].[tr_JoinEventTypeDocumentTypeAudioAudit_d] On [dbo].[JoinEventTypeDocumentTypeAudio]
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
From JoinEventTypeDocumentTypeAudioAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinEventTypeDocumentTypeAudio] = d.[pkJoinEventTypeDocumentTypeAudio]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinEventTypeDocumentTypeAudioAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinEventTypeDocumentTypeAudio]
	,[fkEventType]
	,[fkDocumentType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinEventTypeDocumentTypeAudio]
	,[fkEventType]
	,[fkDocumentType]
From  Deleted
GO
CREATE Trigger [dbo].[tr_JoinEventTypeDocumentTypeAudioAudit_UI] On [dbo].[JoinEventTypeDocumentTypeAudio]
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
From JoinEventTypeDocumentTypeAudioAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinEventTypeDocumentTypeAudio] = i.[pkJoinEventTypeDocumentTypeAudio]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinEventTypeDocumentTypeAudioAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinEventTypeDocumentTypeAudio]
	,[fkEventType]
	,[fkDocumentType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinEventTypeDocumentTypeAudio]
	,[fkEventType]
	,[fkDocumentType]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'For CoPilot, this joins the Audio document types (kept separately from the documents from Capture) to Event Types.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeDocumentTypeAudio';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeDocumentTypeAudio', @level2type = N'COLUMN', @level2name = N'pkJoinEventTypeDocumentTypeAudio';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to EventType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeDocumentTypeAudio', @level2type = N'COLUMN', @level2name = N'fkEventType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to DocumentType in external system', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeDocumentTypeAudio', @level2type = N'COLUMN', @level2name = N'fkDocumentType';

