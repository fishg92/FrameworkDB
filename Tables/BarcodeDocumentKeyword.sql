CREATE TABLE [dbo].[BarcodeDocumentKeyword] (
    [pkBarcodeDocumentKeyword] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkBarcodeDocument]        DECIMAL (18)  NOT NULL,
    [KeywordGroup]             INT           NOT NULL,
    [KeywordName]              VARCHAR (50)  NOT NULL,
    [KeywordValue]             VARCHAR (255) NOT NULL,
    [KeywordID]                VARCHAR (50)  NOT NULL,
    [LUPUser]                  VARCHAR (50)  NULL,
    [LUPDate]                  DATETIME      NULL,
    [CreateUser]               VARCHAR (50)  NULL,
    [CreateDate]               DATETIME      NULL,
    CONSTRAINT [PK_BarcodeDocumentKeyword] PRIMARY KEY CLUSTERED ([pkBarcodeDocumentKeyword] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkBarcodeDocument]
    ON [dbo].[BarcodeDocumentKeyword]([fkBarcodeDocument] ASC);


GO
CREATE Trigger [dbo].[tr_BarcodeDocumentKeywordAudit_UI] On [dbo].[BarcodeDocumentKeyword]
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

Update BarcodeDocumentKeyword
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From BarcodeDocumentKeyword dbTable
	Inner Join Inserted i on dbtable.pkBarcodeDocumentKeyword = i.pkBarcodeDocumentKeyword
	Left Join Deleted d on d.pkBarcodeDocumentKeyword = d.pkBarcodeDocumentKeyword
	Where d.pkBarcodeDocumentKeyword is null

Update BarcodeDocumentKeyword
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From BarcodeDocumentKeyword dbTable
	Inner Join Deleted d on dbTable.pkBarcodeDocumentKeyword = d.pkBarcodeDocumentKeyword
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From BarcodeDocumentKeywordAudit dbTable
Inner Join inserted i ON dbTable.[pkBarcodeDocumentKeyword] = i.[pkBarcodeDocumentKeyword]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into BarcodeDocumentKeywordAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkBarcodeDocumentKeyword]
	,[fkBarcodeDocument]
	,[KeywordGroup]
	,[KeywordName]
	,[KeywordValue]
	,[KeywordID]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkBarcodeDocumentKeyword]
	,[fkBarcodeDocument]
	,[KeywordGroup]
	,[KeywordName]
	,[KeywordValue]
	,[KeywordID]

From  Inserted
GO
CREATE Trigger [dbo].[tr_BarcodeDocumentKeywordAudit_d] On [dbo].[BarcodeDocumentKeyword]
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
From BarcodeDocumentKeywordAudit dbTable
Inner Join deleted d ON dbTable.[pkBarcodeDocumentKeyword] = d.[pkBarcodeDocumentKeyword]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into BarcodeDocumentKeywordAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkBarcodeDocumentKeyword]
	,[fkBarcodeDocument]
	,[KeywordGroup]
	,[KeywordName]
	,[KeywordValue]
	,[KeywordID]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkBarcodeDocumentKeyword]
	,[fkBarcodeDocument]
	,[KeywordGroup]
	,[KeywordName]
	,[KeywordValue]
	,[KeywordID]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Internal use table for bar coding functions', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentKeyword';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, auto-incrementing ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentKeyword', @level2type = N'COLUMN', @level2name = N'pkBarcodeDocumentKeyword';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to parent Barcode table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentKeyword', @level2type = N'COLUMN', @level2name = N'fkBarcodeDocument';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'To which of the clients does this keyword correspond (if a document has multiple associated clients)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentKeyword', @level2type = N'COLUMN', @level2name = N'KeywordGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of the keyword', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentKeyword', @level2type = N'COLUMN', @level2name = N'KeywordName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Value of the keyword', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentKeyword', @level2type = N'COLUMN', @level2name = N'KeywordValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Keyword ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentKeyword', @level2type = N'COLUMN', @level2name = N'KeywordID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentKeyword', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentKeyword', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentKeyword', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentKeyword', @level2type = N'COLUMN', @level2name = N'CreateDate';

