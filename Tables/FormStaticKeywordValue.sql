CREATE TABLE [dbo].[FormStaticKeywordValue] (
    [pkFormStaticKeywordValue] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [StaticKeywordValue]       VARCHAR (100) NOT NULL,
    [LUPUser]                  VARCHAR (50)  NULL,
    [LUPDate]                  DATETIME      NULL,
    [CreateUser]               VARCHAR (50)  NULL,
    [CreateDate]               DATETIME      NULL,
    CONSTRAINT [PK_FormStaticKeywordValue] PRIMARY KEY CLUSTERED ([pkFormStaticKeywordValue] ASC)
);


GO
CREATE NONCLUSTERED INDEX [StaticKeywordValue]
    ON [dbo].[FormStaticKeywordValue]([StaticKeywordValue] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_FormStaticKeywordValueAudit_d] On [dbo].[FormStaticKeywordValue]
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
From FormStaticKeywordValueAudit dbTable
Inner Join deleted d ON dbTable.[pkFormStaticKeywordValue] = d.[pkFormStaticKeywordValue]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormStaticKeywordValueAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormStaticKeywordValue]
	,[StaticKeywordValue]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormStaticKeywordValue]
	,[StaticKeywordValue]
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormStaticKeywordValueAudit_UI] On [dbo].[FormStaticKeywordValue]
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

Update FormStaticKeywordValue
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormStaticKeywordValue dbTable
	Inner Join Inserted i on dbtable.pkFormStaticKeywordValue = i.pkFormStaticKeywordValue
	Left Join Deleted d on d.pkFormStaticKeywordValue = d.pkFormStaticKeywordValue
	Where d.pkFormStaticKeywordValue is null

Update FormStaticKeywordValue
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormStaticKeywordValue dbTable
	Inner Join Deleted d on dbTable.pkFormStaticKeywordValue = d.pkFormStaticKeywordValue
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormStaticKeywordValueAudit dbTable
Inner Join inserted i ON dbTable.[pkFormStaticKeywordValue] = i.[pkFormStaticKeywordValue]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormStaticKeywordValueAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormStaticKeywordValue]
	,[StaticKeywordValue]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormStaticKeywordValue]
	,[StaticKeywordValue]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains the keyword values for keywords that are attached to a form.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormStaticKeywordValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormStaticKeywordValue', @level2type = N'COLUMN', @level2name = N'pkFormStaticKeywordValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Text description of the static keyword.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormStaticKeywordValue', @level2type = N'COLUMN', @level2name = N'StaticKeywordValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormStaticKeywordValue', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormStaticKeywordValue', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormStaticKeywordValue', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormStaticKeywordValue', @level2type = N'COLUMN', @level2name = N'CreateDate';

