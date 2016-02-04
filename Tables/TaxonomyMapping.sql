CREATE TABLE [dbo].[TaxonomyMapping] (
    [pkTaxonomyMapping] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [DocTypeID]         VARCHAR (50)  NOT NULL,
    [DocType]           VARCHAR (100) NOT NULL,
    [DocTypeGroup]      VARCHAR (100) NOT NULL,
    [DocExamples]       VARCHAR (MAX) NOT NULL,
    [LUPUser]           VARCHAR (50)  NULL,
    [LUPDate]           DATETIME      NULL,
    [CreateUser]        VARCHAR (50)  NULL,
    [CreateDate]        DATETIME      NULL,
    CONSTRAINT [PK_TaxonomyMapping] PRIMARY KEY CLUSTERED ([pkTaxonomyMapping] ASC)
);


GO
CREATE Trigger [dbo].[tr_TaxonomyMappingAudit_d] On [dbo].[TaxonomyMapping]
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
From TaxonomyMappingAudit dbTable
Inner Join deleted d ON dbTable.[pkTaxonomyMapping] = d.[pkTaxonomyMapping]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into TaxonomyMappingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkTaxonomyMapping]
	,[DocTypeID]
	,[DocType]
	,[DocTypeGroup]
	,[DocExamples]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkTaxonomyMapping]
	,[DocTypeID]
	,[DocType]
	,[DocTypeGroup]
	,[DocExamples]
From  Deleted
GO
CREATE Trigger [dbo].[tr_TaxonomyMappingAudit_UI] On [dbo].[TaxonomyMapping]
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

Update TaxonomyMapping
	 Set [CreateUser] = @AuditUser
,[CreateDate] = @Date
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From TaxonomyMapping dbTable
	Inner Join Inserted i on dbtable.pkTaxonomyMapping = i.pkTaxonomyMapping
	Left Join Deleted d on d.pkTaxonomyMapping = d.pkTaxonomyMapping
	Where d.pkTaxonomyMapping is null

Update TaxonomyMapping
	 Set [CreateUser] = d.CreateUser
,[CreateDate] = d.CreateDate
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From TaxonomyMapping dbTable
	Inner Join Deleted d on dbTable.pkTaxonomyMapping = d.pkTaxonomyMapping

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From TaxonomyMappingAudit dbTable
Inner Join inserted i ON dbTable.[pkTaxonomyMapping] = i.[pkTaxonomyMapping]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into TaxonomyMappingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkTaxonomyMapping]
	,[DocTypeID]
	,[DocType]
	,[DocTypeGroup]
	,[DocExamples]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkTaxonomyMapping]
	,[DocTypeID]
	,[DocType]
	,[DocTypeGroup]
	,[DocExamples]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table holds the examples for the associated document types.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaxonomyMapping';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaxonomyMapping', @level2type = N'COLUMN', @level2name = N'pkTaxonomyMapping';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Unique Identifier for this Document Type from the DMS', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaxonomyMapping', @level2type = N'COLUMN', @level2name = N'DocTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Friendly name for this Document Type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaxonomyMapping', @level2type = N'COLUMN', @level2name = N'DocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Friendly name for this Document Type Group', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaxonomyMapping', @level2type = N'COLUMN', @level2name = N'DocTypeGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Searchable tags for this document type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaxonomyMapping', @level2type = N'COLUMN', @level2name = N'DocExamples';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaxonomyMapping', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaxonomyMapping', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaxonomyMapping', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TaxonomyMapping', @level2type = N'COLUMN', @level2name = N'CreateDate';

