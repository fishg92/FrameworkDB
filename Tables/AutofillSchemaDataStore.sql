CREATE TABLE [dbo].[AutofillSchemaDataStore] (
    [pkAutofillSchemaDataStore]         DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [FriendlyName]                      VARCHAR (200) NOT NULL,
    [fkrefAutofillSchemaDataSourceType] DECIMAL (18)  NOT NULL,
    CONSTRAINT [PK_AutofillSchemaDataStore] PRIMARY KEY CLUSTERED ([pkAutofillSchemaDataStore] ASC)
);


GO
CREATE Trigger [dbo].[tr_AutofillSchemaDataStoreAudit_UI] On [dbo].[AutofillSchemaDataStore]
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
From AutofillSchemaDataStoreAudit dbTable
Inner Join inserted i ON dbTable.[pkAutofillSchemaDataStore] = i.[pkAutofillSchemaDataStore]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutofillSchemaDataStoreAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutofillSchemaDataStore]
	,[FriendlyName]
	,[fkrefAutofillSchemaDataSourceType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkAutofillSchemaDataStore]
	,[FriendlyName]
	,[fkrefAutofillSchemaDataSourceType]

From  Inserted
GO
CREATE Trigger [dbo].[tr_AutofillSchemaDataStoreAudit_d] On [dbo].[AutofillSchemaDataStore]
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
From AutofillSchemaDataStoreAudit dbTable
Inner Join deleted d ON dbTable.[pkAutofillSchemaDataStore] = d.[pkAutofillSchemaDataStore]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutofillSchemaDataStoreAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutofillSchemaDataStore]
	,[FriendlyName]
	,[fkrefAutofillSchemaDataSourceType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkAutofillSchemaDataStore]
	,[FriendlyName]
	,[fkrefAutofillSchemaDataSourceType]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'List of AutoFill base sources', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataStore';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataStore', @level2type = N'COLUMN', @level2name = N'pkAutofillSchemaDataStore';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Common name of this data store', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataStore', @level2type = N'COLUMN', @level2name = N'FriendlyName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to refAutofillDataSourceType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataStore', @level2type = N'COLUMN', @level2name = N'fkrefAutofillSchemaDataSourceType';

