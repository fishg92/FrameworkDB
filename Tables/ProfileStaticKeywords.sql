CREATE TABLE [dbo].[ProfileStaticKeywords] (
    [pkProfileStaticKeywords] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkProfile]               DECIMAL (18)  NOT NULL,
    [fkKeywordType]           VARCHAR (50)  NOT NULL,
    [KeywordValue]            VARCHAR (100) NOT NULL,
    [LUPUser]                 VARCHAR (50)  NULL,
    [LUPDate]                 DATETIME      NULL,
    [CreateUser]              VARCHAR (50)  NULL,
    [CreateDate]              DATETIME      NULL,
    CONSTRAINT [PK_ProfileStaticKeywords] PRIMARY KEY CLUSTERED ([pkProfileStaticKeywords] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fk_KeywordType]
    ON [dbo].[ProfileStaticKeywords]([fkKeywordType] ASC);


GO
CREATE NONCLUSTERED INDEX [fk_Profile]
    ON [dbo].[ProfileStaticKeywords]([fkProfile] ASC);


GO
CREATE Trigger [dbo].[tr_ProfileStaticKeywordsAudit_UI] On [dbo].[ProfileStaticKeywords]
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

Update ProfileStaticKeywords
	 Set [CreateUser] = @AuditUser
,[CreateDate] = @Date
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From ProfileStaticKeywords dbTable
	Inner Join Inserted i on dbtable.pkProfileStaticKeywords = i.pkProfileStaticKeywords
	Left Join Deleted d on d.pkProfileStaticKeywords = d.pkProfileStaticKeywords
	Where d.pkProfileStaticKeywords is null

Update ProfileStaticKeywords
	 Set [CreateUser] = d.CreateUser
,[CreateDate] = d.CreateDate
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
From ProfileStaticKeywords dbTable
Inner Join Deleted d on d.pkProfileStaticKeywords = d.pkProfileStaticKeywords

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From ProfileStaticKeywordsAudit dbTable
Inner Join inserted i ON dbTable.[pkProfileStaticKeywords] = i.[pkProfileStaticKeywords]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ProfileStaticKeywordsAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkProfileStaticKeywords]
	,[fkProfile]
	,[fkKeywordType]
	,[KeywordValue]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkProfileStaticKeywords]
	,[fkProfile]
	,[fkKeywordType]
	,[KeywordValue]

From  Inserted
GO
CREATE Trigger [dbo].[tr_ProfileStaticKeywordsAudit_d] On [dbo].[ProfileStaticKeywords]
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
From ProfileStaticKeywordsAudit dbTable
Inner Join deleted d ON dbTable.[pkProfileStaticKeywords] = d.[pkProfileStaticKeywords]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ProfileStaticKeywordsAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkProfileStaticKeywords]
	,[fkProfile]
	,[fkKeywordType]
	,[KeywordValue]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkProfileStaticKeywords]
	,[fkProfile]
	,[fkKeywordType]
	,[KeywordValue]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Holds profile-specific static keyword values', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProfileStaticKeywords';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProfileStaticKeywords', @level2type = N'COLUMN', @level2name = N'pkProfileStaticKeywords';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Profile table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProfileStaticKeywords', @level2type = N'COLUMN', @level2name = N'fkProfile';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Internal identifier of keyword assigned by DMS', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProfileStaticKeywords', @level2type = N'COLUMN', @level2name = N'fkKeywordType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Static value of keyword for this profile', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProfileStaticKeywords', @level2type = N'COLUMN', @level2name = N'KeywordValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProfileStaticKeywords', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProfileStaticKeywords', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProfileStaticKeywords', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProfileStaticKeywords', @level2type = N'COLUMN', @level2name = N'CreateDate';

