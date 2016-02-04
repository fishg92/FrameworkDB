CREATE TABLE [dbo].[AutofillSchemaDataViewColumns] (
    [pkAutofillSchemaDataViewColumns] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkAutofillSchemaColumns]         DECIMAL (18)  NOT NULL,
    [fkAutofillSchemaDataView]        DECIMAL (18)  NOT NULL,
    [FriendlyName]                    VARCHAR (150) NOT NULL,
    [Visible]                         TINYINT       NOT NULL,
    [SortOrder]                       INT           NOT NULL,
    [IsUniqueID]                      TINYINT       CONSTRAINT [DF_AutofillSchemaDataViewColumns_IsUniqueID] DEFAULT ((0)) NOT NULL,
    [LUPUser]                         VARCHAR (50)  NULL,
    [LUPDate]                         DATETIME      NULL,
    [CreateUser]                      VARCHAR (50)  NULL,
    [CreateDate]                      DATETIME      NULL,
    CONSTRAINT [PK_AutofillSchemaDataViewColumns] PRIMARY KEY CLUSTERED ([pkAutofillSchemaDataViewColumns] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkAutofillSchemaColumns]
    ON [dbo].[AutofillSchemaDataViewColumns]([fkAutofillSchemaColumns] ASC);


GO
CREATE NONCLUSTERED INDEX [fkAutofillSchemaDataView]
    ON [dbo].[AutofillSchemaDataViewColumns]([fkAutofillSchemaDataView] ASC);


GO
CREATE Trigger [dbo].[tr_AutofillSchemaDataViewColumnsAudit_UI] On [dbo].[AutofillSchemaDataViewColumns]
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

Update AutofillSchemaDataViewColumns
	 Set [CreateUser] = @AuditUser
,[CreateDate] = @Date
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From AutofillSchemaDataViewColumns dbTable
	Inner Join Inserted i on dbtable.pkAutofillSchemaDataViewColumns = i.pkAutofillSchemaDataViewColumns
	Left Join Deleted d on d.pkAutofillSchemaDataViewColumns = d.pkAutofillSchemaDataViewColumns
	Where d.pkAutofillSchemaDataViewColumns is null

Update AutofillSchemaDataViewColumns
	 Set [CreateUser] = d.CreateUser
,[CreateDate] = d.CreateDate
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
 From  AutofillSchemaDataViewColumns dbTable
         Inner Join Deleted d on dbTable.pkAutofillSchemaDataViewColumns = d.pkAutofillSchemaDataViewColumns

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From AutofillSchemaDataViewColumnsAudit dbTable
Inner Join inserted i ON dbTable.[pkAutofillSchemaDataViewColumns] = i.[pkAutofillSchemaDataViewColumns]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutofillSchemaDataViewColumnsAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutofillSchemaDataViewColumns]
	,[fkAutofillSchemaColumns]
	,[fkAutofillSchemaDataView]
	,[FriendlyName]
	,[Visible]
	,[SortOrder]
	,[IsUniqueID]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkAutofillSchemaDataViewColumns]
	,[fkAutofillSchemaColumns]
	,[fkAutofillSchemaDataView]
	,[FriendlyName]
	,[Visible]
	,[SortOrder]
	,[IsUniqueID]

From  Inserted
GO
CREATE Trigger [dbo].[tr_AutofillSchemaDataViewColumnsAudit_d] On [dbo].[AutofillSchemaDataViewColumns]
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
From AutofillSchemaDataViewColumnsAudit dbTable
Inner Join deleted d ON dbTable.[pkAutofillSchemaDataViewColumns] = d.[pkAutofillSchemaDataViewColumns]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutofillSchemaDataViewColumnsAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutofillSchemaDataViewColumns]
	,[fkAutofillSchemaColumns]
	,[fkAutofillSchemaDataView]
	,[FriendlyName]
	,[Visible]
	,[SortOrder]
	,[IsUniqueID]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkAutofillSchemaDataViewColumns]
	,[fkAutofillSchemaColumns]
	,[fkAutofillSchemaDataView]
	,[FriendlyName]
	,[Visible]
	,[SortOrder]
	,[IsUniqueID]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Individual columns in the related AutofillSchemaDataView', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataViewColumns';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataViewColumns', @level2type = N'COLUMN', @level2name = N'pkAutofillSchemaDataViewColumns';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to AutofillSchemaColumns table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataViewColumns', @level2type = N'COLUMN', @level2name = N'fkAutofillSchemaColumns';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to AutofillSchemaDataView table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataViewColumns', @level2type = N'COLUMN', @level2name = N'fkAutofillSchemaDataView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Common name for this column', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataViewColumns', @level2type = N'COLUMN', @level2name = N'FriendlyName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Specifies visibility of this column', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataViewColumns', @level2type = N'COLUMN', @level2name = N'Visible';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Specifies sorting of data in related AutofillSchemaDataView', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataViewColumns', @level2type = N'COLUMN', @level2name = N'SortOrder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'If set, will be used as the unique ID for barcoding instead of Compass Number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataViewColumns', @level2type = N'COLUMN', @level2name = N'IsUniqueID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataViewColumns', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataViewColumns', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataViewColumns', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaDataViewColumns', @level2type = N'COLUMN', @level2name = N'CreateDate';

