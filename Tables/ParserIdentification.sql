CREATE TABLE [dbo].[ParserIdentification] (
    [pkParserIdentification] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [IdentificationString]   VARCHAR (80) NOT NULL,
    [IdentificationRow]      INT          NOT NULL,
    [IdentificationColumn]   INT          NOT NULL,
    [LUPUser]                VARCHAR (50) NULL,
    [LUPDate]                DATETIME     NULL,
    [CreateUser]             VARCHAR (50) NULL,
    [CreateDate]             DATETIME     NULL,
    CONSTRAINT [PK_ParserIdentification] PRIMARY KEY CLUSTERED ([pkParserIdentification] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IdentificationRow_Column]
    ON [dbo].[ParserIdentification]([IdentificationRow] ASC, [IdentificationColumn] ASC)
    INCLUDE([IdentificationString]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [IdentificationString]
    ON [dbo].[ParserIdentification]([IdentificationString] ASC)
    INCLUDE([IdentificationRow], [IdentificationColumn]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_ParserIdentificationAudit_d] On [dbo].[ParserIdentification]
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
From ParserIdentificationAudit dbTable
Inner Join deleted d ON dbTable.[pkParserIdentification] = d.[pkParserIdentification]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ParserIdentificationAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkParserIdentification]
	,[IdentificationString]
	,[IdentificationRow]
	,[IdentificationColumn]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkParserIdentification]
	,[IdentificationString]
	,[IdentificationRow]
	,[IdentificationColumn]
From  Deleted
GO
CREATE Trigger [dbo].[tr_ParserIdentificationAudit_UI] On [dbo].[ParserIdentification]
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

Update ParserIdentification
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ParserIdentification dbTable
	Inner Join Inserted i on dbtable.pkParserIdentification = i.pkParserIdentification
	Left Join Deleted d on d.pkParserIdentification = d.pkParserIdentification
	Where d.pkParserIdentification is null

Update ParserIdentification
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ParserIdentification dbTable
	Inner Join Deleted d on dbTable.pkParserIdentification = d.pkParserIdentification
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From ParserIdentificationAudit dbTable
Inner Join inserted i ON dbTable.[pkParserIdentification] = i.[pkParserIdentification]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ParserIdentificationAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkParserIdentification]
	,[IdentificationString]
	,[IdentificationRow]
	,[IdentificationColumn]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkParserIdentification]
	,[IdentificationString]
	,[IdentificationRow]
	,[IdentificationColumn]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated table - no longer used', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ParserIdentification';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ParserIdentification', @level2type = N'COLUMN', @level2name = N'pkParserIdentification';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ParserIdentification', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ParserIdentification', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ParserIdentification', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ParserIdentification', @level2type = N'COLUMN', @level2name = N'CreateDate';

