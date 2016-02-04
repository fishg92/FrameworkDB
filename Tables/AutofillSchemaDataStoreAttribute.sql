CREATE TABLE [dbo].[AutofillSchemaDataStoreAttribute] (
    [pkAutofillSchemaDataStoreAttribute] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkAutofillSchemaDataStore]          DECIMAL (18)  NOT NULL,
    [ItemKey]                            VARCHAR (100) NOT NULL,
    [ItemValue]                          VARCHAR (500) NOT NULL,
    CONSTRAINT [PK_AutofillSchemaDataStoreAttributes] PRIMARY KEY CLUSTERED ([pkAutofillSchemaDataStoreAttribute] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkAutofillSchemaDataStore]
    ON [dbo].[AutofillSchemaDataStoreAttribute]([fkAutofillSchemaDataStore] ASC);


GO
CREATE Trigger [dbo].[tr_AutofillSchemaDataStoreAttributeAudit_UI] On [dbo].[AutofillSchemaDataStoreAttribute]
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


--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From AutofillSchemaDataStoreAttributeAudit dbTable
Inner Join inserted i ON dbTable.[pkAutofillSchemaDataStoreAttribute] = i.[pkAutofillSchemaDataStoreAttribute]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutofillSchemaDataStoreAttributeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutofillSchemaDataStoreAttribute]
	,[fkAutofillSchemaDataStore]
	,[ItemKey]
	,[ItemValue]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkAutofillSchemaDataStoreAttribute]
	,[fkAutofillSchemaDataStore]
	,[ItemKey]
	,[ItemValue]

From  Inserted
GO
CREATE Trigger [dbo].[tr_AutofillSchemaDataStoreAttributeAudit_d] On [dbo].[AutofillSchemaDataStoreAttribute]
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
From AutofillSchemaDataStoreAttributeAudit dbTable
Inner Join deleted d ON dbTable.[pkAutofillSchemaDataStoreAttribute] = d.[pkAutofillSchemaDataStoreAttribute]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutofillSchemaDataStoreAttributeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutofillSchemaDataStoreAttribute]
	,[fkAutofillSchemaDataStore]
	,[ItemKey]
	,[ItemValue]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkAutofillSchemaDataStoreAttribute]
	,[fkAutofillSchemaDataStore]
	,[ItemKey]
	,[ItemValue]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Individual attributes (credentials, server name, etc.) needed to connect to the associated data store', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataStoreAttribute';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataStoreAttribute', @level2type = N'COLUMN', @level2name = N'pkAutofillSchemaDataStoreAttribute';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to AutofillSchemaDataStore', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataStoreAttribute', @level2type = N'COLUMN', @level2name = N'fkAutofillSchemaDataStore';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Type of attribute', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataStoreAttribute', @level2type = N'COLUMN', @level2name = N'ItemKey';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Value of attribute', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataStoreAttribute', @level2type = N'COLUMN', @level2name = N'ItemValue';

