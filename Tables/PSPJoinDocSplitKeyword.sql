CREATE TABLE [dbo].[PSPJoinDocSplitKeyword] (
    [pkPSPJoinDocSplitKeyword] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkPSPDocSplit]            DECIMAL (18) NOT NULL,
    [fkPSPKeyword]             DECIMAL (18) NOT NULL,
    [LUPUser]                  VARCHAR (50) NULL,
    [LUPDate]                  DATETIME     NULL,
    [CreateUser]               VARCHAR (50) NULL,
    [CreateDate]               DATETIME     NULL,
    CONSTRAINT [PK_PSPJoinDocSplitKeyword] PRIMARY KEY CLUSTERED ([pkPSPJoinDocSplitKeyword] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkPSPDocSplit]
    ON [dbo].[PSPJoinDocSplitKeyword]([fkPSPDocSplit] ASC)
    INCLUDE([fkPSPKeyword]);


GO
CREATE NONCLUSTERED INDEX [fkPSPKeyword]
    ON [dbo].[PSPJoinDocSplitKeyword]([fkPSPKeyword] ASC)
    INCLUDE([fkPSPDocSplit]);


GO
CREATE Trigger [dbo].[tr_PSPJoinDocSplitKeywordAudit_UI] On [dbo].[PSPJoinDocSplitKeyword]
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

Update PSPJoinDocSplitKeyword
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPJoinDocSplitKeyword dbTable
	Inner Join Inserted i on dbtable.pkPSPJoinDocSplitKeyword = i.pkPSPJoinDocSplitKeyword
	Left Join Deleted d on d.pkPSPJoinDocSplitKeyword = d.pkPSPJoinDocSplitKeyword
	Where d.pkPSPJoinDocSplitKeyword is null

Update PSPJoinDocSplitKeyword
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPJoinDocSplitKeyword dbTable
	Inner Join Deleted d on dbTable.pkPSPJoinDocSplitKeyword = d.pkPSPJoinDocSplitKeyword
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From PSPJoinDocSplitKeywordAudit dbTable
Inner Join inserted i ON dbTable.[pkPSPJoinDocSplitKeyword] = i.[pkPSPJoinDocSplitKeyword]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPJoinDocSplitKeywordAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPJoinDocSplitKeyword]
	,[fkPSPDocSplit]
	,[fkPSPKeyword]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkPSPJoinDocSplitKeyword]
	,[fkPSPDocSplit]
	,[fkPSPKeyword]

From  Inserted
GO
CREATE Trigger [dbo].[tr_PSPJoinDocSplitKeywordAudit_d] On [dbo].[PSPJoinDocSplitKeyword]
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
From PSPJoinDocSplitKeywordAudit dbTable
Inner Join deleted d ON dbTable.[pkPSPJoinDocSplitKeyword] = d.[pkPSPJoinDocSplitKeyword]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPJoinDocSplitKeywordAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPJoinDocSplitKeyword]
	,[fkPSPDocSplit]
	,[fkPSPKeyword]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkPSPJoinDocSplitKeyword]
	,[fkPSPDocSplit]
	,[fkPSPKeyword]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPJoinDocSplitKeyword', @level2type = N'COLUMN', @level2name = N'pkPSPJoinDocSplitKeyword';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to PSPDocSplit', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPJoinDocSplitKeyword', @level2type = N'COLUMN', @level2name = N'fkPSPDocSplit';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to PSPKeyword', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPJoinDocSplitKeyword', @level2type = N'COLUMN', @level2name = N'fkPSPKeyword';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPJoinDocSplitKeyword', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPJoinDocSplitKeyword', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPJoinDocSplitKeyword', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPJoinDocSplitKeyword', @level2type = N'COLUMN', @level2name = N'CreateDate';

