CREATE TABLE [dbo].[DocumentTypeGroupDisplaySetting] (
    [pkDocumentTypeGroupDisplaySetting] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkDocumentTypeGroup]               VARCHAR (50) NOT NULL,
    [DisplayColor]                      INT          NOT NULL,
    [Sequence]                          INT          NOT NULL,
    [LUPUser]                           VARCHAR (50) NULL,
    [LUPDate]                           DATETIME     NULL,
    [CreateUser]                        VARCHAR (50) NULL,
    [CreateDate]                        DATETIME     NULL,
    CONSTRAINT [PK_DocumentTypeGroupDisplaySetting] PRIMARY KEY CLUSTERED ([pkDocumentTypeGroupDisplaySetting] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkDocumentTypeGroup]
    ON [dbo].[DocumentTypeGroupDisplaySetting]([fkDocumentTypeGroup] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_DocumentTypeGroupDisplaySettingAudit_d] On [dbo].[DocumentTypeGroupDisplaySetting]
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
From DocumentTypeGroupDisplaySettingAudit dbTable
Inner Join deleted d ON dbTable.[pkDocumentTypeGroupDisplaySetting] = d.[pkDocumentTypeGroupDisplaySetting]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into DocumentTypeGroupDisplaySettingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkDocumentTypeGroupDisplaySetting]
	,[fkDocumentTypeGroup]
	,[DisplayColor]
	,[Sequence]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkDocumentTypeGroupDisplaySetting]
	,[fkDocumentTypeGroup]
	,[DisplayColor]
	,[Sequence]
From  Deleted
GO
CREATE Trigger [dbo].[tr_DocumentTypeGroupDisplaySettingAudit_UI] On [dbo].[DocumentTypeGroupDisplaySetting]
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

Update DocumentTypeGroupDisplaySetting
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From DocumentTypeGroupDisplaySetting dbTable
	Inner Join Inserted i on dbtable.pkDocumentTypeGroupDisplaySetting = i.pkDocumentTypeGroupDisplaySetting
	Left Join Deleted d on d.pkDocumentTypeGroupDisplaySetting = d.pkDocumentTypeGroupDisplaySetting
	Where d.pkDocumentTypeGroupDisplaySetting is null

Update DocumentTypeGroupDisplaySetting
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From DocumentTypeGroupDisplaySetting dbTable
	Inner Join Deleted d on dbTable.pkDocumentTypeGroupDisplaySetting = d.pkDocumentTypeGroupDisplaySetting
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From DocumentTypeGroupDisplaySettingAudit dbTable
Inner Join inserted i ON dbTable.[pkDocumentTypeGroupDisplaySetting] = i.[pkDocumentTypeGroupDisplaySetting]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into DocumentTypeGroupDisplaySettingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkDocumentTypeGroupDisplaySetting]
	,[fkDocumentTypeGroup]
	,[DisplayColor]
	,[Sequence]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkDocumentTypeGroupDisplaySetting]
	,[fkDocumentTypeGroup]
	,[DisplayColor]
	,[Sequence]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Contains information regarding the display of the end user''s taxonomy of document types, including colors and order of display.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeGroupDisplaySetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeGroupDisplaySetting', @level2type = N'COLUMN', @level2name = N'pkDocumentTypeGroupDisplaySetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the document type group', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeGroupDisplaySetting', @level2type = N'COLUMN', @level2name = N'fkDocumentTypeGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Color for the display of the document type group', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeGroupDisplaySetting', @level2type = N'COLUMN', @level2name = N'DisplayColor';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Order in which to display the document type group', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeGroupDisplaySetting', @level2type = N'COLUMN', @level2name = N'Sequence';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeGroupDisplaySetting', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeGroupDisplaySetting', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeGroupDisplaySetting', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeGroupDisplaySetting', @level2type = N'COLUMN', @level2name = N'CreateDate';

