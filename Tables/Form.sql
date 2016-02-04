CREATE TABLE [dbo].[Form] (
    [pkForm]     DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [FormName]   VARCHAR (500) NOT NULL,
    [LUPUser]    VARCHAR (50)  NULL,
    [LUPDate]    DATETIME      NULL,
    [CreateUser] VARCHAR (50)  NULL,
    [CreateDate] DATETIME      NULL,
    CONSTRAINT [PK_FORM] PRIMARY KEY CLUSTERED ([pkForm] ASC)
);


GO
CREATE Trigger [dbo].[tr_FormAudit_d] On [dbo].[Form]
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
From FormAudit dbTable
Inner Join deleted d ON dbTable.[pkForm] = d.[pkForm]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkForm]
	,[FormName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkForm]
	,[FormName]
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormAudit_UI] On [dbo].[Form]
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

Update Form
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From Form dbTable
	Inner Join Inserted i on dbtable.pkForm = i.pkForm
	Left Join Deleted d on d.pkForm = d.pkForm
	Where d.pkForm is null

Update Form
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From Form dbTable
	Inner Join Deleted d on dbTable.pkForm = d.pkForm
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormAudit dbTable
Inner Join inserted i ON dbTable.[pkForm] = i.[pkForm]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkForm]
	,[FormName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkForm]
	,[FormName]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated. Table that contains the form names and is the root of the forms application.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Form';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Form', @level2type = N'COLUMN', @level2name = N'pkForm';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of the form.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Form', @level2type = N'COLUMN', @level2name = N'FormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Form', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Form', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Form', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Form', @level2type = N'COLUMN', @level2name = N'CreateDate';

