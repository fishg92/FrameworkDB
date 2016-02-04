CREATE TABLE [dbo].[KeywordTypeCPKeywordName] (
    [pkKeywordTypeCPKeywordName] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkKeywordType]              VARCHAR (50) NOT NULL,
    [CPKeywordName]              VARCHAR (50) NOT NULL,
    [LUPUser]                    VARCHAR (50) NULL,
    [LUPDate]                    DATETIME     NULL,
    [CreateUser]                 VARCHAR (50) NULL,
    [CreateDate]                 DATETIME     NULL,
    CONSTRAINT [PK_KeywordTypeCPKeywordName] PRIMARY KEY CLUSTERED ([pkKeywordTypeCPKeywordName] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkKeywordType]
    ON [dbo].[KeywordTypeCPKeywordName]([fkKeywordType] ASC)
    INCLUDE([CPKeywordName]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_KeywordTypeCPKeywordNameAudit_UI] On [dbo].[KeywordTypeCPKeywordName]
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

Update KeywordTypeCPKeywordName
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From KeywordTypeCPKeywordName dbTable
	Inner Join Inserted i on dbtable.pkKeywordTypeCPKeywordName = i.pkKeywordTypeCPKeywordName
	Left Join Deleted d on d.pkKeywordTypeCPKeywordName = d.pkKeywordTypeCPKeywordName
	Where d.pkKeywordTypeCPKeywordName is null

Update KeywordTypeCPKeywordName
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From KeywordTypeCPKeywordName dbTable
	Inner Join Deleted d on dbTable.pkKeywordTypeCPKeywordName = d.pkKeywordTypeCPKeywordName
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From KeywordTypeCPKeywordNameAudit dbTable
Inner Join inserted i ON dbTable.[pkKeywordTypeCPKeywordName] = i.[pkKeywordTypeCPKeywordName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into KeywordTypeCPKeywordNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkKeywordTypeCPKeywordName]
	,[fkKeywordType]
	,[CPKeywordName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkKeywordTypeCPKeywordName]
	,[fkKeywordType]
	,[CPKeywordName]

From  Inserted
GO
CREATE Trigger [dbo].[tr_KeywordTypeCPKeywordNameAudit_d] On [dbo].[KeywordTypeCPKeywordName]
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
From KeywordTypeCPKeywordNameAudit dbTable
Inner Join deleted d ON dbTable.[pkKeywordTypeCPKeywordName] = d.[pkKeywordTypeCPKeywordName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into KeywordTypeCPKeywordNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkKeywordTypeCPKeywordName]
	,[fkKeywordType]
	,[CPKeywordName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkKeywordTypeCPKeywordName]
	,[fkKeywordType]
	,[CPKeywordName]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table maps DMS keywords to a fixed set of Compass People values.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeCPKeywordName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeCPKeywordName', @level2type = N'COLUMN', @level2name = N'pkKeywordTypeCPKeywordName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Keyword Type (from DMS)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeCPKeywordName', @level2type = N'COLUMN', @level2name = N'fkKeywordType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Display name in Compass Pilot', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeCPKeywordName', @level2type = N'COLUMN', @level2name = N'CPKeywordName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeCPKeywordName', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeCPKeywordName', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeCPKeywordName', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'KeywordTypeCPKeywordName', @level2type = N'COLUMN', @level2name = N'CreateDate';

