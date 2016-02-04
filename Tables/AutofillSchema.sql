CREATE TABLE [dbo].[AutofillSchema] (
    [pkAutofillSchema]          DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [QueryText]                 VARCHAR (MAX) NOT NULL,
    [FriendlyName]              VARCHAR (150) NULL,
    [fkAutofillSchemaDataStore] DECIMAL (18)  NULL,
    CONSTRAINT [PK_AutofillSchema] PRIMARY KEY CLUSTERED ([pkAutofillSchema] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkAutofillSchemaDataStore]
    ON [dbo].[AutofillSchema]([fkAutofillSchemaDataStore] ASC);


GO
CREATE Trigger [dbo].[tr_AutofillSchemaAudit_d] On [dbo].[AutofillSchema]
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
From AutofillSchemaAudit dbTable
Inner Join deleted d ON dbTable.[pkAutofillSchema] = d.[pkAutofillSchema]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutofillSchemaAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutofillSchema]
	,[QueryText]
	,[FriendlyName]
	,[fkAutofillSchemaDataStore]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkAutofillSchema]
	,[QueryText]
	,[FriendlyName]
	,[fkAutofillSchemaDataStore]
From  Deleted
GO
CREATE Trigger [dbo].[tr_AutofillSchemaAudit_UI] On [dbo].[AutofillSchema]
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
From AutofillSchemaAudit dbTable
Inner Join inserted i ON dbTable.[pkAutofillSchema] = i.[pkAutofillSchema]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutofillSchemaAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutofillSchema]
	,[QueryText]
	,[FriendlyName]
	,[fkAutofillSchemaDataStore]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkAutofillSchema]
	,[QueryText]
	,[FriendlyName]
	,[fkAutofillSchemaDataStore]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Query text used to retrieve data from the associated AutoFill data store', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchema';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchema', @level2type = N'COLUMN', @level2name = N'pkAutofillSchema';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Text of query used to retrieve data', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchema', @level2type = N'COLUMN', @level2name = N'QueryText';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Common name of this AutoFill schema', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchema', @level2type = N'COLUMN', @level2name = N'FriendlyName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to AutoFillDataStore table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchema', @level2type = N'COLUMN', @level2name = N'fkAutofillSchemaDataStore';

