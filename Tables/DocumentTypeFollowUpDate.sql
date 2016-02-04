CREATE TABLE [dbo].[DocumentTypeFollowUpDate] (
    [pkDocumentTypeFollowUpDate] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkDocumentType]             VARCHAR (50) NOT NULL,
    [FollowUpDays]               INT          NULL,
    [FollowUpWeeks]              INT          NULL,
    [FollowUpMonths]             INT          NULL,
    [FollowUpYears]              INT          NULL,
    [LUPUser]                    VARCHAR (50) NULL,
    [LUPDate]                    DATETIME     NULL,
    [CreateUser]                 VARCHAR (50) NULL,
    [CreateDate]                 DATETIME     NULL,
    CONSTRAINT [PK_DocumentTypeFollowUpDateAssignment] PRIMARY KEY CLUSTERED ([pkDocumentTypeFollowUpDate] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkDocumentType]
    ON [dbo].[DocumentTypeFollowUpDate]([fkDocumentType] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_DocumentTypeFollowUpDateAudit_UI] On [dbo].[DocumentTypeFollowUpDate]
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

Update DocumentTypeFollowUpDate
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From DocumentTypeFollowUpDate dbTable
	Inner Join Inserted i on dbtable.pkDocumentTypeFollowUpDate = i.pkDocumentTypeFollowUpDate
	Left Join Deleted d on d.pkDocumentTypeFollowUpDate = d.pkDocumentTypeFollowUpDate
	Where d.pkDocumentTypeFollowUpDate is null

Update DocumentTypeFollowUpDate
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From DocumentTypeFollowUpDate dbTable
	Inner Join Deleted d on dbTable.pkDocumentTypeFollowUpDate = d.pkDocumentTypeFollowUpDate
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From DocumentTypeFollowUpDateAudit dbTable
Inner Join inserted i ON dbTable.[pkDocumentTypeFollowUpDate] = i.[pkDocumentTypeFollowUpDate]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into DocumentTypeFollowUpDateAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkDocumentTypeFollowUpDate]
	,[fkDocumentType]
	,[FollowUpDays]
	,[FollowUpWeeks]
	,[FollowUpMonths]
	,[FollowUpYears]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkDocumentTypeFollowUpDate]
	,[fkDocumentType]
	,[FollowUpDays]
	,[FollowUpWeeks]
	,[FollowUpMonths]
	,[FollowUpYears]

From  Inserted
GO
CREATE Trigger [dbo].[tr_DocumentTypeFollowUpDateAudit_d] On [dbo].[DocumentTypeFollowUpDate]
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
From DocumentTypeFollowUpDateAudit dbTable
Inner Join deleted d ON dbTable.[pkDocumentTypeFollowUpDate] = d.[pkDocumentTypeFollowUpDate]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into DocumentTypeFollowUpDateAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkDocumentTypeFollowUpDate]
	,[fkDocumentType]
	,[FollowUpDays]
	,[FollowUpWeeks]
	,[FollowUpMonths]
	,[FollowUpYears]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkDocumentTypeFollowUpDate]
	,[fkDocumentType]
	,[FollowUpDays]
	,[FollowUpWeeks]
	,[FollowUpMonths]
	,[FollowUpYears]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated - This table contains settings related to follow-up deadlines for document types. This function is now performed by assigning a specific task type to each document type. The task type determines the followup interval.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeFollowUpDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system id number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeFollowUpDate', @level2type = N'COLUMN', @level2name = N'pkDocumentTypeFollowUpDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the document type table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeFollowUpDate', @level2type = N'COLUMN', @level2name = N'fkDocumentType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Days for follow up.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeFollowUpDate', @level2type = N'COLUMN', @level2name = N'FollowUpDays';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Weeks for follow up', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeFollowUpDate', @level2type = N'COLUMN', @level2name = N'FollowUpWeeks';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Months for follow up', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeFollowUpDate', @level2type = N'COLUMN', @level2name = N'FollowUpMonths';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Years for follow up', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeFollowUpDate', @level2type = N'COLUMN', @level2name = N'FollowUpYears';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeFollowUpDate', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeFollowUpDate', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeFollowUpDate', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentTypeFollowUpDate', @level2type = N'COLUMN', @level2name = N'CreateDate';

