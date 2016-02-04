CREATE TABLE [dbo].[DocumentTypeCaseTagging] (
    [pkDocumentTypeCaseTagging] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkDocumentType]            VARCHAR (50) NOT NULL,
    [LUPUser]                   VARCHAR (50) NULL,
    [LUPDate]                   DATETIME     NULL,
    [CreateUser]                VARCHAR (50) NULL,
    [CreateDate]                DATETIME     NULL,
    CONSTRAINT [PK_DocumentTypeCaseTagging] PRIMARY KEY CLUSTERED ([pkDocumentTypeCaseTagging] ASC)
);


GO
CREATE Trigger [dbo].[tr_DocumentTypeCaseTaggingAudit_d] On [dbo].[DocumentTypeCaseTagging]
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
From DocumentTypeCaseTaggingAudit dbTable
Inner Join deleted d ON dbTable.[pkDocumentTypeCaseTagging] = d.[pkDocumentTypeCaseTagging]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into DocumentTypeCaseTaggingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkDocumentTypeCaseTagging]
	,[fkDocumentType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkDocumentTypeCaseTagging]
	,[fkDocumentType]
From  Deleted
GO
CREATE Trigger [dbo].[tr_DocumentTypeCaseTaggingAudit_UI] On [dbo].[DocumentTypeCaseTagging]
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

Update DocumentTypeCaseTagging
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From DocumentTypeCaseTagging dbTable
	Inner Join Inserted i on dbtable.pkDocumentTypeCaseTagging = i.pkDocumentTypeCaseTagging
	Left Join Deleted d on d.pkDocumentTypeCaseTagging = d.pkDocumentTypeCaseTagging
	Where d.pkDocumentTypeCaseTagging is null

Update DocumentTypeCaseTagging
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From DocumentTypeCaseTagging dbTable
	Inner Join Deleted d on dbTable.pkDocumentTypeCaseTagging = d.pkDocumentTypeCaseTagging
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From DocumentTypeCaseTaggingAudit dbTable
Inner Join inserted i ON dbTable.[pkDocumentTypeCaseTagging] = i.[pkDocumentTypeCaseTagging]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into DocumentTypeCaseTaggingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkDocumentTypeCaseTagging]
	,[fkDocumentType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkDocumentTypeCaseTagging]
	,[fkDocumentType]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Contains a record for each document type that implements case tagging functionality', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeCaseTagging';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeCaseTagging', @level2type = N'COLUMN', @level2name = N'pkDocumentTypeCaseTagging';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the document type table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeCaseTagging', @level2type = N'COLUMN', @level2name = N'fkDocumentType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeCaseTagging', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeCaseTagging', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeCaseTagging', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeCaseTagging', @level2type = N'COLUMN', @level2name = N'CreateDate';

