CREATE TABLE [dbo].[AutoPopulateKeyword] (
    [pkAutoPopulateKeyword] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkKeyword]             VARCHAR (50) NOT NULL,
    [ValueID]               SMALLINT     NOT NULL,
    [CanBeOverridden]       BIT          NOT NULL,
    [LUPUser]               VARCHAR (50) NULL,
    [LUPDate]               DATETIME     NULL,
    [CreateUser]            VARCHAR (50) NULL,
    [CreateDate]            DATETIME     NULL,
    CONSTRAINT [PK_AutoPopulateKeyword] PRIMARY KEY CLUSTERED ([pkAutoPopulateKeyword] ASC)
);


GO
CREATE Trigger [dbo].[tr_AutoPopulateKeywordAudit_d] On [dbo].[AutoPopulateKeyword]
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
From AutoPopulateKeywordAudit dbTable
Inner Join deleted d ON dbTable.[pkAutoPopulateKeyword] = d.[pkAutoPopulateKeyword]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutoPopulateKeywordAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutoPopulateKeyword]
	,[fkKeyword]
	,[ValueID]
	,[CanBeOverridden]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkAutoPopulateKeyword]
	,[fkKeyword]
	,[ValueID]
	,[CanBeOverridden]
From  Deleted
GO
CREATE Trigger [dbo].[tr_AutoPopulateKeywordAudit_UI] On [dbo].[AutoPopulateKeyword]
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

Update AutoPopulateKeyword
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From AutoPopulateKeyword dbTable
	Inner Join Inserted i on dbtable.pkAutoPopulateKeyword = i.pkAutoPopulateKeyword
	Left Join Deleted d on d.pkAutoPopulateKeyword = d.pkAutoPopulateKeyword
	Where d.pkAutoPopulateKeyword is null

Update AutoPopulateKeyword
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From AutoPopulateKeyword dbTable
	Inner Join Deleted d on dbTable.pkAutoPopulateKeyword = d.pkAutoPopulateKeyword
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From AutoPopulateKeywordAudit dbTable
Inner Join inserted i ON dbTable.[pkAutoPopulateKeyword] = i.[pkAutoPopulateKeyword]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutoPopulateKeywordAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutoPopulateKeyword]
	,[fkKeyword]
	,[ValueID]
	,[CanBeOverridden]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkAutoPopulateKeyword]
	,[fkKeyword]
	,[ValueID]
	,[CanBeOverridden]

From  Inserted

Update KeywordTypeDisplaySetting
SET IsNotAutoIndexed = 1
FROM KeywordTypeDisplaySetting join inserted ON KeywordTypeDisplaySetting.fkKeywordType = inserted.fkKeyword
	LEFT JOIN deleted on inserted.pkAutoPopulateKeyword = deleted.pkAutoPopulateKeyword 
		WHERE deleted.pkAutoPopulateKeyword IS NULL AND KeywordTypeDisplaySetting.fkProfile = -1
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'1 = Can be overwritten. 0 = Can''t be overwritten.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoPopulateKeyword', @level2type = N'COLUMN', @level2name = N'CanBeOverridden';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoPopulateKeyword', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoPopulateKeyword', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoPopulateKeyword', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoPopulateKeyword', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains the list of keywords that are autopopulated on reindexing, and whether or not they can be overridden.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoPopulateKeyword';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoPopulateKeyword', @level2type = N'COLUMN', @level2name = N'pkAutoPopulateKeyword';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign Key to the Keyword table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoPopulateKeyword', @level2type = N'COLUMN', @level2name = N'fkKeyword';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Orders the list of keywords in the index window', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoPopulateKeyword', @level2type = N'COLUMN', @level2name = N'ValueID';

