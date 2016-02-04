CREATE TABLE [dbo].[DocumentOverlay] (
    [pkDocumentOverlay] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [Description]       VARCHAR (50) NOT NULL,
    [OverlayImage]      IMAGE        NULL,
    [LUPUser]           VARCHAR (50) NULL,
    [LUPDate]           DATETIME     NULL,
    [CreateUser]        VARCHAR (50) NULL,
    [CreateDate]        DATETIME     NULL,
    CONSTRAINT [PK_DocumentOverlay] PRIMARY KEY CLUSTERED ([pkDocumentOverlay] ASC)
);


GO
CREATE Trigger [dbo].[tr_DocumentOverlayAudit_d] On [dbo].[DocumentOverlay]
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
From DocumentOverlayAudit dbTable
Inner Join deleted d ON dbTable.[pkDocumentOverlay] = d.[pkDocumentOverlay]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into DocumentOverlayAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkDocumentOverlay]
	,[Description]
	,[OverlayImage]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkDocumentOverlay]
	,[Description]
	,null
From  Deleted
GO
CREATE Trigger [dbo].[tr_DocumentOverlayAudit_UI] On [dbo].[DocumentOverlay]
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

Update DocumentOverlay
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From DocumentOverlay dbTable
	Inner Join Inserted i on dbtable.pkDocumentOverlay = i.pkDocumentOverlay
	Left Join Deleted d on d.pkDocumentOverlay = d.pkDocumentOverlay
	Where d.pkDocumentOverlay is null

Update DocumentOverlay
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From DocumentOverlay dbTable
	Inner Join Deleted d on dbTable.pkDocumentOverlay = d.pkDocumentOverlay
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From DocumentOverlayAudit dbTable
Inner Join inserted i ON dbTable.[pkDocumentOverlay] = i.[pkDocumentOverlay]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into DocumentOverlayAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkDocumentOverlay]
	,[Description]
	,[OverlayImage]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkDocumentOverlay]
	,[Description]
	,null

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'A description of the overlay', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentOverlay', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Image to lay over the document', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentOverlay', @level2type = N'COLUMN', @level2name = N'OverlayImage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentOverlay', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentOverlay', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentOverlay', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentOverlay', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores images to use as overlay for various documents.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentOverlay';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentOverlay', @level2type = N'COLUMN', @level2name = N'pkDocumentOverlay';

