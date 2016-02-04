CREATE TABLE [dbo].[FormGroup] (
    [pkFormGroup]     DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkFormGroupName] DECIMAL (18) NOT NULL,
    [Status]          TINYINT      CONSTRAINT [DF_FormGroup_Status] DEFAULT ((0)) NOT NULL,
    [LUPUser]         VARCHAR (50) NULL,
    [LUPDate]         DATETIME     NULL,
    [CreateUser]      VARCHAR (50) NULL,
    [CreateDate]      DATETIME     NULL,
    CONSTRAINT [PK_FormGroup] PRIMARY KEY CLUSTERED ([pkFormGroup] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormGroupName]
    ON [dbo].[FormGroup]([fkFormGroupName] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_FormGroupAudit_d] On [dbo].[FormGroup]
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
From FormGroupAudit dbTable
Inner Join deleted d ON dbTable.[pkFormGroup] = d.[pkFormGroup]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormGroupAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormGroup]
	,[fkFormGroupName]
	,[Status]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormGroup]
	,[fkFormGroupName]
	,[Status]
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormGroupAudit_UI] On [dbo].[FormGroup]
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

Update FormGroup
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormGroup dbTable
	Inner Join Inserted i on dbtable.pkFormGroup = i.pkFormGroup
	Left Join Deleted d on d.pkFormGroup = d.pkFormGroup
	Where d.pkFormGroup is null

Update FormGroup
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormGroup dbTable
	Inner Join Deleted d on dbTable.pkFormGroup = d.pkFormGroup
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormGroupAudit dbTable
Inner Join inserted i ON dbTable.[pkFormGroup] = i.[pkFormGroup]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormGroupAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormGroup]
	,[fkFormGroupName]
	,[Status]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormGroup]
	,[fkFormGroupName]
	,[Status]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table is a collection point for various properties of form groups within Pilot Forms', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID Number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormGroup', @level2type = N'COLUMN', @level2name = N'pkFormGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the (possibly overnormalized) group name table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormGroup', @level2type = N'COLUMN', @level2name = N'fkFormGroupName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Status of the group', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormGroup', @level2type = N'COLUMN', @level2name = N'Status';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormGroup', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormGroup', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormGroup', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormGroup', @level2type = N'COLUMN', @level2name = N'CreateDate';

