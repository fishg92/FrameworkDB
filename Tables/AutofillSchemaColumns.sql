CREATE TABLE [dbo].[AutofillSchemaColumns] (
    [pkAutofillSchemaColumns] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkAutofillSchema]        DECIMAL (18)  NOT NULL,
    [FieldName]               VARCHAR (150) NOT NULL,
    [FieldOrder]              INT           NOT NULL,
    [CompassPeopleField]      VARCHAR (50)  CONSTRAINT [DF_AutofillSchemaColumns_CompassPeopleField] DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_AutofillSchemaColumns] PRIMARY KEY CLUSTERED ([pkAutofillSchemaColumns] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkAutofillSchema]
    ON [dbo].[AutofillSchemaColumns]([fkAutofillSchema] ASC);


GO
CREATE Trigger [dbo].[tr_AutofillSchemaColumnsAudit_d] On [dbo].[AutofillSchemaColumns]
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
From AutofillSchemaColumnsAudit dbTable
Inner Join deleted d ON dbTable.[pkAutofillSchemaColumns] = d.[pkAutofillSchemaColumns]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutofillSchemaColumnsAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutofillSchemaColumns]
	,[fkAutofillSchema]
	,[FieldName]
	,[FieldOrder]
	,[CompassPeopleField]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkAutofillSchemaColumns]
	,[fkAutofillSchema]
	,[FieldName]
	,[FieldOrder]
	,[CompassPeopleField]
From  Deleted
GO
CREATE Trigger [dbo].[tr_AutofillSchemaColumnsAudit_UI] On [dbo].[AutofillSchemaColumns]
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
From AutofillSchemaColumnsAudit dbTable
Inner Join inserted i ON dbTable.[pkAutofillSchemaColumns] = i.[pkAutofillSchemaColumns]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutofillSchemaColumnsAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutofillSchemaColumns]
	,[fkAutofillSchema]
	,[FieldName]
	,[FieldOrder]
	,[CompassPeopleField]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkAutofillSchemaColumns]
	,[fkAutofillSchema]
	,[FieldName]
	,[FieldOrder]
	,[CompassPeopleField]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'List of columns within a specific AutoFill schema', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaColumns';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaColumns', @level2type = N'COLUMN', @level2name = N'pkAutofillSchemaColumns';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to AutoFillSchema table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaColumns', @level2type = N'COLUMN', @level2name = N'fkAutofillSchema';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of field within the associated schema', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaColumns', @level2type = N'COLUMN', @level2name = N'FieldName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Retrieval order for the data field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaColumns', @level2type = N'COLUMN', @level2name = N'FieldOrder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Associated value in CompassPeople data', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaColumns', @level2type = N'COLUMN', @level2name = N'CompassPeopleField';

