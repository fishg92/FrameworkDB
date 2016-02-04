CREATE TABLE [dbo].[DocumentTypeGroupKeywordTypeTabDisplaySetting] (
    [pkDocumentTypeGroupKeywordTypeTabDisplaySetting] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkDocumentTypeGroup]                             DECIMAL (18) NULL,
    [fkKeywordType]                                   VARCHAR (50) NOT NULL,
    [Sequence]                                        INT          NOT NULL,
    [LUPUser]                                         VARCHAR (50) NULL,
    [LUPDate]                                         DATETIME     NULL,
    [CreateUser]                                      VARCHAR (50) NULL,
    [CreateDate]                                      DATETIME     NULL,
    CONSTRAINT [PK_DocumentTypeGroupKeywordTypeTabDisplaySetting] PRIMARY KEY CLUSTERED ([pkDocumentTypeGroupKeywordTypeTabDisplaySetting] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkDocumentTypeGroup_fkKeywordType]
    ON [dbo].[DocumentTypeGroupKeywordTypeTabDisplaySetting]([fkDocumentTypeGroup] ASC, [fkKeywordType] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_DocumentTypeGroupKeywordTypeTabDisplaySettingAudit_d] On [dbo].[DocumentTypeGroupKeywordTypeTabDisplaySetting]
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
From DocumentTypeGroupKeywordTypeTabDisplaySettingAudit dbTable
Inner Join deleted d ON dbTable.[pkDocumentTypeGroupKeywordTypeTabDisplaySetting] = d.[pkDocumentTypeGroupKeywordTypeTabDisplaySetting]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into DocumentTypeGroupKeywordTypeTabDisplaySettingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkDocumentTypeGroupKeywordTypeTabDisplaySetting]
	,[fkDocumentTypeGroup]
	,[fkKeywordType]
	,[Sequence]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkDocumentTypeGroupKeywordTypeTabDisplaySetting]
	,[fkDocumentTypeGroup]
	,[fkKeywordType]
	,[Sequence]
From  Deleted
GO
CREATE Trigger [dbo].[tr_DocumentTypeGroupKeywordTypeTabDisplaySettingAudit_UI] On [dbo].[DocumentTypeGroupKeywordTypeTabDisplaySetting]
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

Update DocumentTypeGroupKeywordTypeTabDisplaySetting
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From DocumentTypeGroupKeywordTypeTabDisplaySetting dbTable
	Inner Join Inserted i on dbtable.pkDocumentTypeGroupKeywordTypeTabDisplaySetting = i.pkDocumentTypeGroupKeywordTypeTabDisplaySetting
	Left Join Deleted d on d.pkDocumentTypeGroupKeywordTypeTabDisplaySetting = d.pkDocumentTypeGroupKeywordTypeTabDisplaySetting
	Where d.pkDocumentTypeGroupKeywordTypeTabDisplaySetting is null

Update DocumentTypeGroupKeywordTypeTabDisplaySetting
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From DocumentTypeGroupKeywordTypeTabDisplaySetting dbTable
	Inner Join Deleted d on dbTable.pkDocumentTypeGroupKeywordTypeTabDisplaySetting = d.pkDocumentTypeGroupKeywordTypeTabDisplaySetting
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From DocumentTypeGroupKeywordTypeTabDisplaySettingAudit dbTable
Inner Join inserted i ON dbTable.[pkDocumentTypeGroupKeywordTypeTabDisplaySetting] = i.[pkDocumentTypeGroupKeywordTypeTabDisplaySetting]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into DocumentTypeGroupKeywordTypeTabDisplaySettingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkDocumentTypeGroupKeywordTypeTabDisplaySetting]
	,[fkDocumentTypeGroup]
	,[fkKeywordType]
	,[Sequence]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkDocumentTypeGroupKeywordTypeTabDisplaySetting]
	,[fkDocumentTypeGroup]
	,[fkKeywordType]
	,[Sequence]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table holds informaton to determine the selection and display order of keywords used to create tabs in the Documents display grid.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeGroupKeywordTypeTabDisplaySetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeGroupKeywordTypeTabDisplaySetting', @level2type = N'COLUMN', @level2name = N'pkDocumentTypeGroupKeywordTypeTabDisplaySetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the document type group table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeGroupKeywordTypeTabDisplaySetting', @level2type = N'COLUMN', @level2name = N'fkDocumentTypeGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the keyword type table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeGroupKeywordTypeTabDisplaySetting', @level2type = N'COLUMN', @level2name = N'fkKeywordType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Order in which they keyword types should be shown.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeGroupKeywordTypeTabDisplaySetting', @level2type = N'COLUMN', @level2name = N'Sequence';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeGroupKeywordTypeTabDisplaySetting', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeGroupKeywordTypeTabDisplaySetting', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeGroupKeywordTypeTabDisplaySetting', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeGroupKeywordTypeTabDisplaySetting', @level2type = N'COLUMN', @level2name = N'CreateDate';

