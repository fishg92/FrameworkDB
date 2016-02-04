CREATE TABLE [dbo].[refAutofillSchemaDataStoreType] (
    [pkrefAutofillSchemaDataStoreType] DECIMAL (18)  NOT NULL,
    [FriendlyName]                     VARCHAR (150) NOT NULL,
    CONSTRAINT [PK_refAutofillSchemaDataSourceType] PRIMARY KEY CLUSTERED ([pkrefAutofillSchemaDataStoreType] ASC)
);


GO
CREATE Trigger [dbo].[tr_refAutofillSchemaDataStoreTypeAudit_UI] On [dbo].[refAutofillSchemaDataStoreType]
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
From refAutofillSchemaDataStoreTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkrefAutofillSchemaDataStoreType] = i.[pkrefAutofillSchemaDataStoreType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refAutofillSchemaDataStoreTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefAutofillSchemaDataStoreType]
	,[FriendlyName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkrefAutofillSchemaDataStoreType]
	,[FriendlyName]

From  Inserted
GO
CREATE Trigger [dbo].[tr_refAutofillSchemaDataStoreTypeAudit_d] On [dbo].[refAutofillSchemaDataStoreType]
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
From refAutofillSchemaDataStoreTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkrefAutofillSchemaDataStoreType] = d.[pkrefAutofillSchemaDataStoreType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refAutofillSchemaDataStoreTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefAutofillSchemaDataStoreType]
	,[FriendlyName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkrefAutofillSchemaDataStoreType]
	,[FriendlyName]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ref tables are reference tables that are used to populate drop downs, enumerate options, or otherwise provide a (usually) static list of items to the program. In this case, it is the listing of Autofill Schema Data Store Types that can be selected.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refAutofillSchemaDataStoreType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refAutofillSchemaDataStoreType', @level2type = N'COLUMN', @level2name = N'pkrefAutofillSchemaDataStoreType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the Autofill Schema Data Store', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refAutofillSchemaDataStoreType', @level2type = N'COLUMN', @level2name = N'FriendlyName';

