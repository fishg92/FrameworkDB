CREATE TABLE [dbo].[ParserKeyValue] (
    [pkParserKeyValue]       DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkParserIdentification] DECIMAL (18) NOT NULL,
    [KeyValueRow]            INT          NOT NULL,
    [KeyValueColumn]         INT          NOT NULL,
    [KeyValueLength]         INT          NOT NULL,
    [KeyValueSearchName]     VARCHAR (50) NOT NULL,
    [LUPUser]                VARCHAR (50) NULL,
    [LUPDate]                DATETIME     NULL,
    [CreateUser]             VARCHAR (50) NULL,
    [CreateDate]             DATETIME     NULL,
    CONSTRAINT [PK_ParserKeyValue] PRIMARY KEY CLUSTERED ([pkParserKeyValue] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkParserIdentification]
    ON [dbo].[ParserKeyValue]([fkParserIdentification] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_ParserKeyValueAudit_UI] On [dbo].[ParserKeyValue]
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

Update ParserKeyValue
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ParserKeyValue dbTable
	Inner Join Inserted i on dbtable.pkParserKeyValue = i.pkParserKeyValue
	Left Join Deleted d on d.pkParserKeyValue = d.pkParserKeyValue
	Where d.pkParserKeyValue is null

Update ParserKeyValue
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ParserKeyValue dbTable
	Inner Join Deleted d on dbTable.pkParserKeyValue = d.pkParserKeyValue
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From ParserKeyValueAudit dbTable
Inner Join inserted i ON dbTable.[pkParserKeyValue] = i.[pkParserKeyValue]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ParserKeyValueAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkParserKeyValue]
	,[fkParserIdentification]
	,[KeyValueRow]
	,[KeyValueColumn]
	,[KeyValueLength]
	,[KeyValueSearchName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkParserKeyValue]
	,[fkParserIdentification]
	,[KeyValueRow]
	,[KeyValueColumn]
	,[KeyValueLength]
	,[KeyValueSearchName]

From  Inserted
GO
CREATE Trigger [dbo].[tr_ParserKeyValueAudit_d] On [dbo].[ParserKeyValue]
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
From ParserKeyValueAudit dbTable
Inner Join deleted d ON dbTable.[pkParserKeyValue] = d.[pkParserKeyValue]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ParserKeyValueAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkParserKeyValue]
	,[fkParserIdentification]
	,[KeyValueRow]
	,[KeyValueColumn]
	,[KeyValueLength]
	,[KeyValueSearchName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkParserKeyValue]
	,[fkParserIdentification]
	,[KeyValueRow]
	,[KeyValueColumn]
	,[KeyValueLength]
	,[KeyValueSearchName]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated table - no longer used', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ParserKeyValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ParserKeyValue', @level2type = N'COLUMN', @level2name = N'pkParserKeyValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ParserKeyValue', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ParserKeyValue', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ParserKeyValue', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ParserKeyValue', @level2type = N'COLUMN', @level2name = N'CreateDate';

