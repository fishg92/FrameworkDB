CREATE TABLE [dbo].[JoinEventTypeDocumentTypeCapture] (
    [pkJoinEventTypeDocumentTypeCapture] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkEventType]                        DECIMAL (18) NULL,
    [fkDocumentType]                     VARCHAR (50) NULL,
    [SystemGeneratedCaption]             BIT          CONSTRAINT [DF_JoinEventTypeDocumentTypeCapture_SystemGeneratedCaption] DEFAULT ((0)) NOT NULL,
    [LUPUser]                            VARCHAR (50) NULL,
    [LUPDate]                            DATETIME     NULL,
    [CreateUser]                         VARCHAR (50) NULL,
    [CreateDate]                         DATETIME     NULL,
    CONSTRAINT [PK_JoinEventTypeDocumentTypeCapture] PRIMARY KEY CLUSTERED ([pkJoinEventTypeDocumentTypeCapture] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkDocumentType]
    ON [dbo].[JoinEventTypeDocumentTypeCapture]([fkDocumentType] ASC)
    INCLUDE([fkEventType]);


GO
CREATE NONCLUSTERED INDEX [fkEventType]
    ON [dbo].[JoinEventTypeDocumentTypeCapture]([fkEventType] ASC)
    INCLUDE([fkDocumentType]);


GO
CREATE Trigger [dbo].[tr_JoinEventTypeDocumentTypeCaptureAudit_d] On [dbo].[JoinEventTypeDocumentTypeCapture]
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
From JoinEventTypeDocumentTypeCaptureAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinEventTypeDocumentTypeCapture] = d.[pkJoinEventTypeDocumentTypeCapture]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinEventTypeDocumentTypeCaptureAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinEventTypeDocumentTypeCapture]
	,[fkEventType]
	,[fkDocumentType]
	,[SystemGeneratedCaption]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinEventTypeDocumentTypeCapture]
	,[fkEventType]
	,[fkDocumentType]
	,[SystemGeneratedCaption]
From  Deleted
GO
CREATE Trigger [dbo].[tr_JoinEventTypeDocumentTypeCaptureAudit_UI] On [dbo].[JoinEventTypeDocumentTypeCapture]
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

Update JoinEventTypeDocumentTypeCapture
	 Set [CreateUser] = @AuditUser
,[CreateDate] = @Date
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From JoinEventTypeDocumentTypeCapture dbTable
	Inner Join Inserted i on dbtable.pkJoinEventTypeDocumentTypeCapture = i.pkJoinEventTypeDocumentTypeCapture
	Left Join Deleted d on d.pkJoinEventTypeDocumentTypeCapture = d.pkJoinEventTypeDocumentTypeCapture
	Where d.pkJoinEventTypeDocumentTypeCapture is null

Update JoinEventTypeDocumentTypeCapture
	 Set [CreateUser] = d.CreateUser
,[CreateDate] = d.Createdate
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
FROM JoinEventTypeDocumentTypeCapture JETDTC
Inner Join Deleted d on JETDTC.pkJoinEventTypeDocumentTypeCapture = d.pkJoinEventTypeDocumentTypeCapture

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinEventTypeDocumentTypeCaptureAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinEventTypeDocumentTypeCapture] = i.[pkJoinEventTypeDocumentTypeCapture]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinEventTypeDocumentTypeCaptureAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinEventTypeDocumentTypeCapture]
	,[fkEventType]
	,[fkDocumentType]
	,[SystemGeneratedCaption]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinEventTypeDocumentTypeCapture]
	,[fkEventType]
	,[fkDocumentType]
	,[SystemGeneratedCaption]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table joins documents from Capture to Event Types in CoPilot', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeDocumentTypeCapture';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeDocumentTypeCapture', @level2type = N'COLUMN', @level2name = N'pkJoinEventTypeDocumentTypeCapture';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the event type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeDocumentTypeCapture', @level2type = N'COLUMN', @level2name = N'fkEventType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the document type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeDocumentTypeCapture', @level2type = N'COLUMN', @level2name = N'fkDocumentType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Holds a boolean value indicating whether or not CoPilot will automatically generate a caption for a document of this type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeDocumentTypeCapture', @level2type = N'COLUMN', @level2name = N'SystemGeneratedCaption';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last updated user', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeDocumentTypeCapture', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last updated date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeDocumentTypeCapture', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Create user', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeDocumentTypeCapture', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Create date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinEventTypeDocumentTypeCapture', @level2type = N'COLUMN', @level2name = N'CreateDate';

