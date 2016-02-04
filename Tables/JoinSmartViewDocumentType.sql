CREATE TABLE [dbo].[JoinSmartViewDocumentType] (
    [pkJoinSmartViewDocumentType] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [NumberOfDisplayedDocs]       INT           CONSTRAINT [DF_JoinSmartViewDocumentTypeDisplaySetting_NumberOfDisplayedDocs] DEFAULT ((0)) NOT NULL,
    [NumberOfDaysToDisplay]       DECIMAL (18)  CONSTRAINT [DF_Table_1_DateRangeDay] DEFAULT ((0)) NOT NULL,
    [fkSmartView]                 DECIMAL (18)  NOT NULL,
    [fkDocumentType]              VARCHAR (255) NOT NULL,
    [IncludeInSmartView]          BIT           NOT NULL,
    [NumberOfMonthsToDisplay]     INT           CONSTRAINT [DF_JoinSmartViewDocumentType_NumberOfMonthsToDisplay] DEFAULT ((0)) NOT NULL,
    [NumberOfYearsToDisplay]      INT           CONSTRAINT [DF_JoinSmartViewDocumentType_NumberOfYearsToDisplay] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_JoinSmartViewDocumentTypeDisplaySetting] PRIMARY KEY CLUSTERED ([pkJoinSmartViewDocumentType] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkDocumentType]
    ON [dbo].[JoinSmartViewDocumentType]([fkDocumentType] ASC)
    INCLUDE([fkSmartView]);


GO
CREATE NONCLUSTERED INDEX [fkSmartView]
    ON [dbo].[JoinSmartViewDocumentType]([fkSmartView] ASC)
    INCLUDE([fkDocumentType]);


GO
CREATE Trigger [dbo].[tr_JoinSmartViewDocumentTypeAudit_UI] On [dbo].[JoinSmartViewDocumentType]
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
From JoinSmartViewDocumentTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinSmartViewDocumentType] = i.[pkJoinSmartViewDocumentType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinSmartViewDocumentTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinSmartViewDocumentType]
	,[NumberOfDisplayedDocs]
	,[NumberOfDaysToDisplay]
	,[fkSmartView]
	,[fkDocumentType]
	,[IncludeInSmartView]
	,[NumberOfMonthsToDisplay]
	,[NumberOfYearsToDisplay]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinSmartViewDocumentType]
	,[NumberOfDisplayedDocs]
	,[NumberOfDaysToDisplay]
	,[fkSmartView]
	,[fkDocumentType]
	,[IncludeInSmartView]
	,[NumberOfMonthsToDisplay]
	,[NumberOfYearsToDisplay]
From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinSmartViewDocumentTypeAudit_d] On [dbo].[JoinSmartViewDocumentType]
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
From JoinSmartViewDocumentTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinSmartViewDocumentType] = d.[pkJoinSmartViewDocumentType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinSmartViewDocumentTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinSmartViewDocumentType]
	,[NumberOfDisplayedDocs]
	,[NumberOfDaysToDisplay]
	,[fkSmartView]
	,[fkDocumentType]
	,[IncludeInSmartView]
	,[NumberOfMonthsToDisplay]
	,[NumberOfYearsToDisplay]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinSmartViewDocumentType]
	,[NumberOfDisplayedDocs]
	,[NumberOfDaysToDisplay]
	,[fkSmartView]
	,[fkDocumentType]
	,[IncludeInSmartView]
	,[NumberOfMonthsToDisplay]
	,[NumberOfYearsToDisplay]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table controls how different smart views display different doctypes.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinSmartViewDocumentType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinSmartViewDocumentType', @level2type = N'COLUMN', @level2name = N'pkJoinSmartViewDocumentType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'How many docs to display in the smart view', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinSmartViewDocumentType', @level2type = N'COLUMN', @level2name = N'NumberOfDisplayedDocs';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'How many days to display in the smart view', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinSmartViewDocumentType', @level2type = N'COLUMN', @level2name = N'NumberOfDaysToDisplay';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to SmartView', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinSmartViewDocumentType', @level2type = N'COLUMN', @level2name = N'fkSmartView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to DocumentType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinSmartViewDocumentType', @level2type = N'COLUMN', @level2name = N'fkDocumentType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Whether or not to include this doc type in the smart view', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinSmartViewDocumentType', @level2type = N'COLUMN', @level2name = N'IncludeInSmartView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'How many months to display in the smart view', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinSmartViewDocumentType', @level2type = N'COLUMN', @level2name = N'NumberOfMonthsToDisplay';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'How many years to display in the smart view', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinSmartViewDocumentType', @level2type = N'COLUMN', @level2name = N'NumberOfYearsToDisplay';

