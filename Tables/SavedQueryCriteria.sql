CREATE TABLE [dbo].[SavedQueryCriteria] (
    [pkSavedQueryCriteria] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkSavedQuery]         DECIMAL (18)  NOT NULL,
    [fkKeyword]            VARCHAR (50)  NOT NULL,
    [KeywordValue]         VARCHAR (50)  NULL,
    [KeywordStartDate]     SMALLDATETIME NULL,
    [KeywordEndDate]       SMALLDATETIME NULL,
    [LUPUser]              VARCHAR (50)  NULL,
    [LUPDate]              DATETIME      NULL,
    [CreateUser]           VARCHAR (50)  NULL,
    [CreateDate]           DATETIME      NULL,
    CONSTRAINT [PK_SavedQueryCriteria] PRIMARY KEY CLUSTERED ([pkSavedQueryCriteria] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkSavedQuery]
    ON [dbo].[SavedQueryCriteria]([fkSavedQuery] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_SavedQueryCriteriaAudit_d] On [dbo].[SavedQueryCriteria]
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
From SavedQueryCriteriaAudit dbTable
Inner Join deleted d ON dbTable.[pkSavedQueryCriteria] = d.[pkSavedQueryCriteria]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into SavedQueryCriteriaAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkSavedQueryCriteria]
	,[fkSavedQuery]
	,[fkKeyword]
	,[KeywordValue]
	,[KeywordStartDate]
	,[KeywordEndDate]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkSavedQueryCriteria]
	,[fkSavedQuery]
	,[fkKeyword]
	,[KeywordValue]
	,[KeywordStartDate]
	,[KeywordEndDate]
From  Deleted
GO
CREATE Trigger [dbo].[tr_SavedQueryCriteriaAudit_UI] On [dbo].[SavedQueryCriteria]
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

Update SavedQueryCriteria
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From SavedQueryCriteria dbTable
	Inner Join Inserted i on dbtable.pkSavedQueryCriteria = i.pkSavedQueryCriteria
	Left Join Deleted d on d.pkSavedQueryCriteria = d.pkSavedQueryCriteria
	Where d.pkSavedQueryCriteria is null

Update SavedQueryCriteria
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From SavedQueryCriteria dbTable
	Inner Join Deleted d on dbTable.pkSavedQueryCriteria = d.pkSavedQueryCriteria
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From SavedQueryCriteriaAudit dbTable
Inner Join inserted i ON dbTable.[pkSavedQueryCriteria] = i.[pkSavedQueryCriteria]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into SavedQueryCriteriaAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkSavedQueryCriteria]
	,[fkSavedQuery]
	,[fkKeyword]
	,[KeywordValue]
	,[KeywordStartDate]
	,[KeywordEndDate]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkSavedQueryCriteria]
	,[fkSavedQuery]
	,[fkKeyword]
	,[KeywordValue]
	,[KeywordStartDate]
	,[KeywordEndDate]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Individual search criteria for user-defined saved document queries', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQueryCriteria';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQueryCriteria', @level2type = N'COLUMN', @level2name = N'pkSavedQueryCriteria';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the SavedQuery table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQueryCriteria', @level2type = N'COLUMN', @level2name = N'fkSavedQuery';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to pull in whatever keyword is used in this criteria', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQueryCriteria', @level2type = N'COLUMN', @level2name = N'fkKeyword';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What value(s) should the keyword match?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQueryCriteria', @level2type = N'COLUMN', @level2name = N'KeywordValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'For date-range criteria, what''s the start date?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQueryCriteria', @level2type = N'COLUMN', @level2name = N'KeywordStartDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'For date-range keywords, when should that date-range end?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQueryCriteria', @level2type = N'COLUMN', @level2name = N'KeywordEndDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQueryCriteria', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQueryCriteria', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQueryCriteria', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQueryCriteria', @level2type = N'COLUMN', @level2name = N'CreateDate';

