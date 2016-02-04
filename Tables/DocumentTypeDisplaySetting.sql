CREATE TABLE [dbo].[DocumentTypeDisplaySetting] (
    [pkDocumentTypeDisplaySetting]      DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkDocumentType]                    VARCHAR (50)  NOT NULL,
    [NumberOfDisplayedDocs]             INT           CONSTRAINT [DF_DocumentTypeDisplaySetting_NumberOfDisplayedDocs] DEFAULT ((0)) NOT NULL,
    [DateRangeDay]                      INT           CONSTRAINT [DF_DocumentTypeDisplaySetting_DateRangeDay] DEFAULT ((0)) NOT NULL,
    [DateRangeMonth]                    INT           CONSTRAINT [DF_DocumentTypeDisplaySetting_DateRangeMonth] DEFAULT ((0)) NOT NULL,
    [DateRangeYear]                     INT           CONSTRAINT [DF_DocumentTypeDisplaySetting_DateRangeYear] DEFAULT ((0)) NOT NULL,
    [LUPUser]                           VARCHAR (50)  NULL,
    [LUPDate]                           DATETIME      NULL,
    [CreateUser]                        VARCHAR (50)  NULL,
    [CreateDate]                        DATETIME      NULL,
    [fkDocumentOverlay]                 DECIMAL (18)  NULL,
    [fkTaskType]                        DECIMAL (18)  NULL,
    [DocTypeDescription_SupportUseOnly] VARCHAR (500) CONSTRAINT [DF_DocumentTypeDisplaySetting_Description] DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_DocumentType] PRIMARY KEY CLUSTERED ([pkDocumentTypeDisplaySetting] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [fkDocumentType]
    ON [dbo].[DocumentTypeDisplaySetting]([fkDocumentType] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkDocumentOverlay]
    ON [dbo].[DocumentTypeDisplaySetting]([fkDocumentOverlay] ASC);


GO
CREATE Trigger [dbo].[tr_DocumentTypeDisplaySettingAudit_UI] On [dbo].[DocumentTypeDisplaySetting]
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

Update DocumentTypeDisplaySetting
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From DocumentTypeDisplaySetting dbTable
	Inner Join Inserted i on dbtable.pkDocumentTypeDisplaySetting = i.pkDocumentTypeDisplaySetting
	Left Join Deleted d on d.pkDocumentTypeDisplaySetting = d.pkDocumentTypeDisplaySetting
	Where d.pkDocumentTypeDisplaySetting is null

Update DocumentTypeDisplaySetting
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From DocumentTypeDisplaySetting dbTable
	Inner Join Deleted d on dbTable.pkDocumentTypeDisplaySetting = d.pkDocumentTypeDisplaySetting
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From DocumentTypeDisplaySettingAudit dbTable
Inner Join inserted i ON dbTable.[pkDocumentTypeDisplaySetting] = i.[pkDocumentTypeDisplaySetting]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into DocumentTypeDisplaySettingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkDocumentTypeDisplaySetting]
	,[fkDocumentType]
	,[NumberOfDisplayedDocs]
	,[DateRangeDay]
	,[DateRangeMonth]
	,[DateRangeYear]
	,[fkDocumentOverlay]
	,[fkTaskType]
	,[DocTypeDescription_SupportUseOnly]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkDocumentTypeDisplaySetting]
	,[fkDocumentType]
	,[NumberOfDisplayedDocs]
	,[DateRangeDay]
	,[DateRangeMonth]
	,[DateRangeYear]
	,[fkDocumentOverlay]
	,[fkTaskType]
	,[DocTypeDescription_SupportUseOnly]

From  Inserted
GO
CREATE Trigger [dbo].[tr_DocumentTypeDisplaySettingAudit_d] On [dbo].[DocumentTypeDisplaySetting]
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
From DocumentTypeDisplaySettingAudit dbTable
Inner Join deleted d ON dbTable.[pkDocumentTypeDisplaySetting] = d.[pkDocumentTypeDisplaySetting]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into DocumentTypeDisplaySettingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkDocumentTypeDisplaySetting]
	,[fkDocumentType]
	,[NumberOfDisplayedDocs]
	,[DateRangeDay]
	,[DateRangeMonth]
	,[DateRangeYear]
	,[fkDocumentOverlay]
	,[fkTaskType]
	,[DocTypeDescription_SupportUseOnly]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkDocumentTypeDisplaySetting]
	,[fkDocumentType]
	,[NumberOfDisplayedDocs]
	,[DateRangeDay]
	,[DateRangeMonth]
	,[DateRangeYear]
	,[fkDocumentOverlay]
	,[fkTaskType]
	,[DocTypeDescription_SupportUseOnly]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains settings that are used to help control the display from the smart grid view.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeDisplaySetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'pkDocumentTypeDisplaySetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the document type table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'fkDocumentType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'How many documents to display of this type in the UI', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'NumberOfDisplayedDocs';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date range to display, days', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'DateRangeDay';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date range to display, months', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'DateRangeMonth';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date range to display, years', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'DateRangeYear';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Document Overlay table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'fkDocumentOverlay';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to task type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'fkTaskType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Long, human readable description of the document type for support', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeDisplaySetting', @level2type = N'COLUMN', @level2name = N'DocTypeDescription_SupportUseOnly';

