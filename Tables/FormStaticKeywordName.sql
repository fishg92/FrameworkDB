CREATE TABLE [dbo].[FormStaticKeywordName] (
    [pkFormStaticKeywordName] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkKeywordType]           VARCHAR (50) NOT NULL,
    [LUPUser]                 VARCHAR (50) NULL,
    [LUPDate]                 DATETIME     NULL,
    [CreateUser]              VARCHAR (50) NULL,
    [CreateDate]              DATETIME     NULL,
    CONSTRAINT [PK_FormStaticKeywordName] PRIMARY KEY CLUSTERED ([pkFormStaticKeywordName] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkKeywordType]
    ON [dbo].[FormStaticKeywordName]([fkKeywordType] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_FormStaticKeywordNameAudit_UI] On [dbo].[FormStaticKeywordName]
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

Update FormStaticKeywordName
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormStaticKeywordName dbTable
	Inner Join Inserted i on dbtable.pkFormStaticKeywordName = i.pkFormStaticKeywordName
	Left Join Deleted d on d.pkFormStaticKeywordName = d.pkFormStaticKeywordName
	Where d.pkFormStaticKeywordName is null

Update FormStaticKeywordName
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormStaticKeywordName dbTable
	Inner Join Deleted d on dbTable.pkFormStaticKeywordName = d.pkFormStaticKeywordName
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormStaticKeywordNameAudit dbTable
Inner Join inserted i ON dbTable.[pkFormStaticKeywordName] = i.[pkFormStaticKeywordName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormStaticKeywordNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormStaticKeywordName]
	,[fkKeywordType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormStaticKeywordName]
	,[fkKeywordType]

From  Inserted
GO
CREATE Trigger [dbo].[tr_FormStaticKeywordNameAudit_d] On [dbo].[FormStaticKeywordName]
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
From FormStaticKeywordNameAudit dbTable
Inner Join deleted d ON dbTable.[pkFormStaticKeywordName] = d.[pkFormStaticKeywordName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormStaticKeywordNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormStaticKeywordName]
	,[fkKeywordType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormStaticKeywordName]
	,[fkKeywordType]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This form is a passthrough to the keywords in the various document management systems.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormStaticKeywordName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID Number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormStaticKeywordName', @level2type = N'COLUMN', @level2name = N'pkFormStaticKeywordName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to keyword type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormStaticKeywordName', @level2type = N'COLUMN', @level2name = N'fkKeywordType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormStaticKeywordName', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormStaticKeywordName', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormStaticKeywordName', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormStaticKeywordName', @level2type = N'COLUMN', @level2name = N'CreateDate';

