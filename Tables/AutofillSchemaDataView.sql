CREATE TABLE [dbo].[AutofillSchemaDataView] (
    [pkAutofillSchemaDataView]    DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkAutofillSchema]            DECIMAL (18)  NOT NULL,
    [FriendlyName]                VARCHAR (150) NOT NULL,
    [IgnoreProgramTypeSecurity]   TINYINT       CONSTRAINT [DF_AutofillSchemaDataView_IgnoreProgramTypeSecurity] DEFAULT ((0)) NOT NULL,
    [IgnoreSecuredClientSecurity] TINYINT       CONSTRAINT [DF_AutofillSchemaDataView_IgnoreSecuredClientSecurity] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_AutofillSchemaDataView] PRIMARY KEY CLUSTERED ([pkAutofillSchemaDataView] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkAutofillSchema]
    ON [dbo].[AutofillSchemaDataView]([fkAutofillSchema] ASC);


GO
CREATE Trigger [dbo].[tr_AutofillSchemaDataViewAudit_UI] On [dbo].[AutofillSchemaDataView]
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
From AutofillSchemaDataViewAudit dbTable
Inner Join inserted i ON dbTable.[pkAutofillSchemaDataView] = i.[pkAutofillSchemaDataView]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutofillSchemaDataViewAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutofillSchemaDataView]
	,[fkAutofillSchema]
	,[FriendlyName]
	,[IgnoreProgramTypeSecurity]
	,[IgnoreSecuredClientSecurity]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkAutofillSchemaDataView]
	,[fkAutofillSchema]
	,[FriendlyName]
	,[IgnoreProgramTypeSecurity]
	,[IgnoreSecuredClientSecurity]

From  Inserted
GO
CREATE Trigger [dbo].[tr_AutofillSchemaDataViewAudit_d] On [dbo].[AutofillSchemaDataView]
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
From AutofillSchemaDataViewAudit dbTable
Inner Join deleted d ON dbTable.[pkAutofillSchemaDataView] = d.[pkAutofillSchemaDataView]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutofillSchemaDataViewAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutofillSchemaDataView]
	,[fkAutofillSchema]
	,[FriendlyName]
	,[IgnoreProgramTypeSecurity]
	,[IgnoreSecuredClientSecurity]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkAutofillSchemaDataView]
	,[fkAutofillSchema]
	,[FriendlyName]
	,[IgnoreProgramTypeSecurity]
	,[IgnoreSecuredClientSecurity]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Specific views of a defined AutofillSchema object', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataView', @level2type = N'COLUMN', @level2name = N'pkAutofillSchemaDataView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to AutofillSchema table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataView', @level2type = N'COLUMN', @level2name = N'fkAutofillSchema';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Common name for this record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataView', @level2type = N'COLUMN', @level2name = N'FriendlyName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Are program type security rules bypassed for this schema?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataView', @level2type = N'COLUMN', @level2name = N'IgnoreProgramTypeSecurity';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Are secured client rules bypassed for this schema?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataView', @level2type = N'COLUMN', @level2name = N'IgnoreSecuredClientSecurity';

