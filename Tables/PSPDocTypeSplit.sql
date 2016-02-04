CREATE TABLE [dbo].[PSPDocTypeSplit] (
    [pkPSPDocTypeSplit]                DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkPSPDocType]                     DECIMAL (18)  NOT NULL,
    [SubmitToDMS]                      BIT           NOT NULL,
    [CopyToFolder]                     BIT           NOT NULL,
    [fkKeywordForFolderName]           VARCHAR (50)  NOT NULL,
    [StaticFolderName]                 VARCHAR (100) NOT NULL,
    [CreateDocumentWhenKeywordChanges] DECIMAL (18)  NOT NULL,
    [CreateDocumentEveryXPages]        INT           NOT NULL,
    [CreateXDocuments]                 INT           NOT NULL,
    [Enabled]                          BIT           NOT NULL,
    [LUPUser]                          VARCHAR (50)  NULL,
    [LUPDate]                          DATETIME      NULL,
    [CreateUser]                       VARCHAR (50)  NULL,
    [CreateDate]                       DATETIME      NULL,
    CONSTRAINT [PK_PSPDocTypeSplit] PRIMARY KEY CLUSTERED ([pkPSPDocTypeSplit] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkPSPDocType]
    ON [dbo].[PSPDocTypeSplit]([fkPSPDocType] ASC);


GO
CREATE Trigger [dbo].[tr_PSPDocTypeSplitAudit_UI] On [dbo].[PSPDocTypeSplit]
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

Update PSPDocTypeSplit
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPDocTypeSplit dbTable
	Inner Join Inserted i on dbtable.pkPSPDocTypeSplit = i.pkPSPDocTypeSplit
	Left Join Deleted d on d.pkPSPDocTypeSplit = d.pkPSPDocTypeSplit
	Where d.pkPSPDocTypeSplit is null

Update PSPDocTypeSplit
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPDocTypeSplit dbTable
	Inner Join Deleted d on dbTable.pkPSPDocTypeSplit = d.pkPSPDocTypeSplit
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From PSPDocTypeSplitAudit dbTable
Inner Join inserted i ON dbTable.[pkPSPDocTypeSplit] = i.[pkPSPDocTypeSplit]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPDocTypeSplitAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPDocTypeSplit]
	,[fkPSPDocType]
	,[SubmitToDMS]
	,[CopyToFolder]
	,[fkKeywordForFolderName]
	,[StaticFolderName]
	,[CreateDocumentWhenKeywordChanges]
	,[CreateDocumentEveryXPages]
	,[CreateXDocuments]
	,[Enabled]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkPSPDocTypeSplit]
	,[fkPSPDocType]
	,[SubmitToDMS]
	,[CopyToFolder]
	,[fkKeywordForFolderName]
	,[StaticFolderName]
	,[CreateDocumentWhenKeywordChanges]
	,[CreateDocumentEveryXPages]
	,[CreateXDocuments]
	,[Enabled]

From  Inserted
GO
CREATE Trigger [dbo].[tr_PSPDocTypeSplitAudit_d] On [dbo].[PSPDocTypeSplit]
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
From PSPDocTypeSplitAudit dbTable
Inner Join deleted d ON dbTable.[pkPSPDocTypeSplit] = d.[pkPSPDocTypeSplit]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPDocTypeSplitAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPDocTypeSplit]
	,[fkPSPDocType]
	,[SubmitToDMS]
	,[CopyToFolder]
	,[fkKeywordForFolderName]
	,[StaticFolderName]
	,[CreateDocumentWhenKeywordChanges]
	,[CreateDocumentEveryXPages]
	,[CreateXDocuments]
	,[Enabled]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkPSPDocTypeSplit]
	,[fkPSPDocType]
	,[SubmitToDMS]
	,[CopyToFolder]
	,[fkKeywordForFolderName]
	,[StaticFolderName]
	,[CreateDocumentWhenKeywordChanges]
	,[CreateDocumentEveryXPages]
	,[CreateXDocuments]
	,[Enabled]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Holds values controlling the document splitting process within PSP', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocTypeSplit';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocTypeSplit', @level2type = N'COLUMN', @level2name = N'pkPSPDocTypeSplit';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to PSPDocType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocTypeSplit', @level2type = N'COLUMN', @level2name = N'fkPSPDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocTypeSplit', @level2type = N'COLUMN', @level2name = N'SubmitToDMS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocTypeSplit', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocTypeSplit', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocTypeSplit', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocTypeSplit', @level2type = N'COLUMN', @level2name = N'CreateDate';

