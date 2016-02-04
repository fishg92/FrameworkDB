CREATE TABLE [dbo].[BarcodeDocument] (
    [pkBarcodeDocument] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkFormName]        DECIMAL (18) NOT NULL,
    [PageCount]         INT          NOT NULL,
    [SendDate]          DATETIME     NOT NULL,
    [LUPUser]           VARCHAR (50) NULL,
    [LUPDate]           DATETIME     NULL,
    [CreateUser]        VARCHAR (50) NULL,
    [CreateDate]        DATETIME     NULL,
    [fkPSPDocType]      DECIMAL (18) NULL,
    CONSTRAINT [PK_BarcodeDocument] PRIMARY KEY CLUSTERED ([pkBarcodeDocument] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormName]
    ON [dbo].[BarcodeDocument]([fkFormName] ASC);


GO
CREATE NONCLUSTERED INDEX [fkPSPDocType]
    ON [dbo].[BarcodeDocument]([fkPSPDocType] ASC);


GO
CREATE Trigger [dbo].[tr_BarcodeDocumentAudit_d] On [dbo].[BarcodeDocument]
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
From BarcodeDocumentAudit dbTable
Inner Join deleted d ON dbTable.[pkBarcodeDocument] = d.[pkBarcodeDocument]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into BarcodeDocumentAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkBarcodeDocument]
	,[fkFormName]
	,[PageCount]
	,[SendDate]
	,[fkPSPDocType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkBarcodeDocument]
	,[fkFormName]
	,[PageCount]
	,[SendDate]
	,[fkPSPDocType]
From  Deleted
GO
CREATE Trigger [dbo].[tr_BarcodeDocumentAudit_UI] On [dbo].[BarcodeDocument]
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

Update BarcodeDocument
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From BarcodeDocument dbTable
	Inner Join Inserted i on dbtable.pkBarcodeDocument = i.pkBarcodeDocument
	Left Join Deleted d on d.pkBarcodeDocument = d.pkBarcodeDocument
	Where d.pkBarcodeDocument is null

Update BarcodeDocument
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From BarcodeDocument dbTable
	Inner Join Deleted d on dbTable.pkBarcodeDocument = d.pkBarcodeDocument
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From BarcodeDocumentAudit dbTable
Inner Join inserted i ON dbTable.[pkBarcodeDocument] = i.[pkBarcodeDocument]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into BarcodeDocumentAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkBarcodeDocument]
	,[fkFormName]
	,[PageCount]
	,[SendDate]
	,[fkPSPDocType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkBarcodeDocument]
	,[fkFormName]
	,[PageCount]
	,[SendDate]
	,[fkPSPDocType]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Internal use table for bar coding functions', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocument';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocument', @level2type = N'COLUMN', @level2name = N'pkBarcodeDocument';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormName', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocument', @level2type = N'COLUMN', @level2name = N'fkFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'How many pages are in the barcoded document', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocument', @level2type = N'COLUMN', @level2name = N'PageCount';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date the document was sent out into the world.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocument', @level2type = N'COLUMN', @level2name = N'SendDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocument', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocument', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocument', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocument', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the PSP Document Type table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BarcodeDocument', @level2type = N'COLUMN', @level2name = N'fkPSPDocType';

