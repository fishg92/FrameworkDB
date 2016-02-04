CREATE TABLE [dbo].[RefCredentialType] (
    [pkRefCredentialType] DECIMAL (18)  NOT NULL,
    [Description]         VARCHAR (255) NOT NULL,
    [LUPUser]             VARCHAR (50)  NULL,
    [LUPDate]             DATETIME      NULL,
    [CreateUser]          VARCHAR (50)  NULL,
    [CreateDate]          DATETIME      NULL,
    CONSTRAINT [PK_RefCredentialType] PRIMARY KEY CLUSTERED ([pkRefCredentialType] ASC)
);


GO
CREATE Trigger [dbo].[tr_RefCredentialTypeAudit_UI] On [dbo].[RefCredentialType]
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

Update RefCredentialType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From RefCredentialType dbTable
	Inner Join Inserted i on dbtable.pkRefCredentialType = i.pkRefCredentialType
	Left Join Deleted d on d.pkRefCredentialType = d.pkRefCredentialType
	Where d.pkRefCredentialType is null

Update RefCredentialType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From RefCredentialType dbTable
	Inner Join Deleted d on dbTable.pkRefCredentialType = d.pkRefCredentialType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From RefCredentialTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkRefCredentialType] = i.[pkRefCredentialType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into RefCredentialTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkRefCredentialType]
	,[Description]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkRefCredentialType]
	,[Description]

From  Inserted
GO
CREATE Trigger [dbo].[tr_RefCredentialTypeAudit_d] On [dbo].[RefCredentialType]
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
From RefCredentialTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkRefCredentialType] = d.[pkRefCredentialType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into RefCredentialTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkRefCredentialType]
	,[Description]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkRefCredentialType]
	,[Description]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ref tables are reference tables that are used to populate drop downs, enumerate options, or otherwise provide a (usually) static list of items to the program. In this case, it contains lookup information to describe different authentication sources.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefCredentialType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefCredentialType', @level2type = N'COLUMN', @level2name = N'pkRefCredentialType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the credential type to show in the User Interface', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefCredentialType', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefCredentialType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefCredentialType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefCredentialType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RefCredentialType', @level2type = N'COLUMN', @level2name = N'CreateDate';

