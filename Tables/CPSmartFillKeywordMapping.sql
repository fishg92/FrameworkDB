CREATE TABLE [dbo].[CPSmartFillKeywordMapping] (
    [pkCPSmartFillKeywordMapping] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [PeopleKeyword]               VARCHAR (100) NULL,
    [SmartFillAlias]              VARCHAR (100) NULL,
    [LUPUser]                     VARCHAR (50)  NULL,
    [LUPDate]                     DATETIME      NULL,
    [CreateUser]                  VARCHAR (50)  NULL,
    [CreateDate]                  DATETIME      NULL,
    CONSTRAINT [PK_CPSmartFillKeywordMapping] PRIMARY KEY CLUSTERED ([pkCPSmartFillKeywordMapping] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPeopleKeyword]
    ON [dbo].[CPSmartFillKeywordMapping]([PeopleKeyword] ASC)
    INCLUDE([SmartFillAlias]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [idxSmartFillAlias]
    ON [dbo].[CPSmartFillKeywordMapping]([SmartFillAlias] ASC)
    INCLUDE([PeopleKeyword]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_CPSmartFillKeywordMappingAudit_UI] On [dbo].[CPSmartFillKeywordMapping]
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

Update CPSmartFillKeywordMapping
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPSmartFillKeywordMapping dbTable
	Inner Join Inserted i on dbtable.pkCPSmartFillKeywordMapping = i.pkCPSmartFillKeywordMapping
	Left Join Deleted d on d.pkCPSmartFillKeywordMapping = d.pkCPSmartFillKeywordMapping
	Where d.pkCPSmartFillKeywordMapping is null

Update CPSmartFillKeywordMapping
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPSmartFillKeywordMapping dbTable
	Inner Join Deleted d on dbTable.pkCPSmartFillKeywordMapping = d.pkCPSmartFillKeywordMapping
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPSmartFillKeywordMappingAudit dbTable
Inner Join inserted i ON dbTable.[pkCPSmartFillKeywordMapping] = i.[pkCPSmartFillKeywordMapping]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPSmartFillKeywordMappingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPSmartFillKeywordMapping]
	,[PeopleKeyword]
	,[SmartFillAlias]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPSmartFillKeywordMapping]
	,[PeopleKeyword]
	,[SmartFillAlias]

From  Inserted
GO
CREATE Trigger [dbo].[tr_CPSmartFillKeywordMappingAudit_d] On [dbo].[CPSmartFillKeywordMapping]
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
From CPSmartFillKeywordMappingAudit dbTable
Inner Join deleted d ON dbTable.[pkCPSmartFillKeywordMapping] = d.[pkCPSmartFillKeywordMapping]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPSmartFillKeywordMappingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPSmartFillKeywordMapping]
	,[PeopleKeyword]
	,[SmartFillAlias]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPSmartFillKeywordMapping]
	,[PeopleKeyword]
	,[SmartFillAlias]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPSmartFillKeywordMapping', @level2type = N'COLUMN', @level2name = N'pkCPSmartFillKeywordMapping';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPSmartFillKeywordMapping', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPSmartFillKeywordMapping', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPSmartFillKeywordMapping', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPSmartFillKeywordMapping', @level2type = N'COLUMN', @level2name = N'CreateDate';

