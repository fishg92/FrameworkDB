CREATE TABLE [dbo].[BarcodeDocumentPage] (
    [pkBarcodeDocumentPage] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkBarcodeDocument]     DECIMAL (18)  NOT NULL,
    [PageNumber]            INT           NOT NULL,
    [LUPUser]               VARCHAR (50)  NULL,
    [LUPDate]               DATETIME      NULL,
    [CreateUser]            VARCHAR (50)  NULL,
    [CreateDate]            DATETIME      NULL,
    [PageScanned]           BIT           NULL,
    [ReturnDate]            SMALLDATETIME NULL,
    CONSTRAINT [PK_BarcodeDocumentPage] PRIMARY KEY CLUSTERED ([pkBarcodeDocumentPage] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkBarcodeDocument]
    ON [dbo].[BarcodeDocumentPage]([fkBarcodeDocument] ASC);


GO
CREATE Trigger [dbo].[tr_BarcodeDocumentPageAudit_d] On [dbo].[BarcodeDocumentPage]
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
From BarcodeDocumentPageAudit dbTable
Inner Join deleted d ON dbTable.[pkBarcodeDocumentPage] = d.[pkBarcodeDocumentPage]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into BarcodeDocumentPageAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkBarcodeDocumentPage]
	,[fkBarcodeDocument]
	,[PageNumber]
	,[PageScanned]
	,[ReturnDate]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkBarcodeDocumentPage]
	,[fkBarcodeDocument]
	,[PageNumber]
	,[PageScanned]
	,[ReturnDate]
From  Deleted
GO
CREATE Trigger [dbo].[tr_BarcodeDocumentPageAudit_UI] On [dbo].[BarcodeDocumentPage]
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

Update BarcodeDocumentPage
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From BarcodeDocumentPage dbTable
	Inner Join Inserted i on dbtable.pkBarcodeDocumentPage = i.pkBarcodeDocumentPage
	Left Join Deleted d on d.pkBarcodeDocumentPage = d.pkBarcodeDocumentPage
	Where d.pkBarcodeDocumentPage is null

Update BarcodeDocumentPage
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From BarcodeDocumentPage dbTable
	Inner Join Deleted d on dbTable.pkBarcodeDocumentPage = d.pkBarcodeDocumentPage
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From BarcodeDocumentPageAudit dbTable
Inner Join inserted i ON dbTable.[pkBarcodeDocumentPage] = i.[pkBarcodeDocumentPage]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into BarcodeDocumentPageAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkBarcodeDocumentPage]
	,[fkBarcodeDocument]
	,[PageNumber]
	,[PageScanned]
	,[ReturnDate]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkBarcodeDocumentPage]
	,[fkBarcodeDocument]
	,[PageNumber]
	,[PageScanned]
	,[ReturnDate]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentPage', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentPage', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentPage', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Has this page been scanned yet.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentPage', @level2type = N'COLUMN', @level2name = N'PageScanned';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'On what day the page has been scanned and returned to the agency.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentPage', @level2type = N'COLUMN', @level2name = N'ReturnDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Internal use table for bar coding functions', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentPage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Aribtrary, auto-incrementing ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentPage', @level2type = N'COLUMN', @level2name = N'pkBarcodeDocumentPage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to parent table, BarcodeDocument', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentPage', @level2type = N'COLUMN', @level2name = N'fkBarcodeDocument';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Which of the pages of the document this record represents.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentPage', @level2type = N'COLUMN', @level2name = N'PageNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocumentPage', @level2type = N'COLUMN', @level2name = N'LUPUser';

