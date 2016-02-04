CREATE TABLE [dbo].[refCashReceiptFieldType] (
    [pkrefCashReceiptFieldType] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [FieldTypeName]             VARCHAR (50) NOT NULL,
    [FieldTypeValue]            INT          NOT NULL,
    [LUPUser]                   VARCHAR (50) NULL,
    [LUPDate]                   DATETIME     NULL,
    [CreateUser]                VARCHAR (50) NULL,
    [CreateDate]                DATETIME     NULL,
    CONSTRAINT [PK_refCashReceiptFieldType] PRIMARY KEY CLUSTERED ([pkrefCashReceiptFieldType] ASC)
);


GO
CREATE NONCLUSTERED INDEX [FieldTypeName]
    ON [dbo].[refCashReceiptFieldType]([FieldTypeName] ASC)
    INCLUDE([FieldTypeValue]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_refCashReceiptFieldTypeAudit_d] On [dbo].[refCashReceiptFieldType]
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
From refCashReceiptFieldTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkrefCashReceiptFieldType] = d.[pkrefCashReceiptFieldType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refCashReceiptFieldTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefCashReceiptFieldType]
	,[FieldTypeName]
	,[FieldTypeValue]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkrefCashReceiptFieldType]
	,[FieldTypeName]
	,[FieldTypeValue]
From  Deleted
GO
CREATE Trigger [dbo].[tr_refCashReceiptFieldTypeAudit_UI] On [dbo].[refCashReceiptFieldType]
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

Update refCashReceiptFieldType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refCashReceiptFieldType dbTable
	Inner Join Inserted i on dbtable.pkrefCashReceiptFieldType = i.pkrefCashReceiptFieldType
	Left Join Deleted d on d.pkrefCashReceiptFieldType = d.pkrefCashReceiptFieldType
	Where d.pkrefCashReceiptFieldType is null

Update refCashReceiptFieldType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refCashReceiptFieldType dbTable
	Inner Join Deleted d on dbTable.pkrefCashReceiptFieldType = d.pkrefCashReceiptFieldType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From refCashReceiptFieldTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkrefCashReceiptFieldType] = i.[pkrefCashReceiptFieldType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refCashReceiptFieldTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefCashReceiptFieldType]
	,[FieldTypeName]
	,[FieldTypeValue]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkrefCashReceiptFieldType]
	,[FieldTypeName]
	,[FieldTypeValue]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'A deprecated table. Ref tables are reference tables that are used to populate drop downs, enumerate options, or otherwise provide a (usually) static list of items to the program. In this case, it stored reference information for Cash Receipts.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refCashReceiptFieldType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refCashReceiptFieldType', @level2type = N'COLUMN', @level2name = N'pkrefCashReceiptFieldType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup ID for the referenced value', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refCashReceiptFieldType', @level2type = N'COLUMN', @level2name = N'FieldTypeValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refCashReceiptFieldType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refCashReceiptFieldType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refCashReceiptFieldType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refCashReceiptFieldType', @level2type = N'COLUMN', @level2name = N'CreateDate';

