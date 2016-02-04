CREATE TABLE [dbo].[FormJoinFormNameFormGroup] (
    [pkFormJoinFormNameFormGroup]       DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkFormGroup]                       DECIMAL (18) NOT NULL,
    [fkFormName]                        DECIMAL (18) NOT NULL,
    [fkFormJoinFormNameFormGroupParent] DECIMAL (18) CONSTRAINT [DF_FormJoinFormNameFormGroup_fkFormJoinFormNameFormGroupParent] DEFAULT ((0)) NOT NULL,
    [fkFormGroupFormCaption]            DECIMAL (18) CONSTRAINT [DF_FormJoinFormNameFormGroup_fkFormGroupFormCaption] DEFAULT ((0)) NOT NULL,
    [Copies]                            INT          CONSTRAINT [DF_FormJoinFormNameFormGroup_DefaultCopies] DEFAULT ((1)) NOT NULL,
    [FormOrder]                         INT          CONSTRAINT [DF_FormJoinFormNameFormGroup_FormOrder] DEFAULT ((0)) NOT NULL,
    [LUPUser]                           VARCHAR (50) NULL,
    [LUPDate]                           DATETIME     NULL,
    [CreateUser]                        VARCHAR (50) NULL,
    [CreateDate]                        DATETIME     NULL,
    CONSTRAINT [PK_FormJoinFormNameFormGroup] PRIMARY KEY CLUSTERED ([pkFormJoinFormNameFormGroup] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormGroup]
    ON [dbo].[FormJoinFormNameFormGroup]([fkFormGroup] ASC)
    INCLUDE([fkFormGroupFormCaption], [fkFormJoinFormNameFormGroupParent], [fkFormName]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkFormName]
    ON [dbo].[FormJoinFormNameFormGroup]([fkFormName] ASC)
    INCLUDE([fkFormGroup], [fkFormGroupFormCaption], [fkFormJoinFormNameFormGroupParent]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_FormJoinFormNameFormGroupAudit_UI] On [dbo].[FormJoinFormNameFormGroup]
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

Update FormJoinFormNameFormGroup
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormJoinFormNameFormGroup dbTable
	Inner Join Inserted i on dbtable.pkFormJoinFormNameFormGroup = i.pkFormJoinFormNameFormGroup
	Left Join Deleted d on d.pkFormJoinFormNameFormGroup = d.pkFormJoinFormNameFormGroup
	Where d.pkFormJoinFormNameFormGroup is null

Update FormJoinFormNameFormGroup
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormJoinFormNameFormGroup dbTable
	Inner Join Deleted d on dbTable.pkFormJoinFormNameFormGroup = d.pkFormJoinFormNameFormGroup
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormJoinFormNameFormGroupAudit dbTable
Inner Join inserted i ON dbTable.[pkFormJoinFormNameFormGroup] = i.[pkFormJoinFormNameFormGroup]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormJoinFormNameFormGroupAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormJoinFormNameFormGroup]
	,[fkFormGroup]
	,[fkFormName]
	,[fkFormJoinFormNameFormGroupParent]
	,[fkFormGroupFormCaption]
	,[Copies]
	,[FormOrder]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormJoinFormNameFormGroup]
	,[fkFormGroup]
	,[fkFormName]
	,[fkFormJoinFormNameFormGroupParent]
	,[fkFormGroupFormCaption]
	,[Copies]
	,[FormOrder]

From  Inserted
GO
CREATE Trigger [dbo].[tr_FormJoinFormNameFormGroupAudit_d] On [dbo].[FormJoinFormNameFormGroup]
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
From FormJoinFormNameFormGroupAudit dbTable
Inner Join deleted d ON dbTable.[pkFormJoinFormNameFormGroup] = d.[pkFormJoinFormNameFormGroup]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormJoinFormNameFormGroupAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormJoinFormNameFormGroup]
	,[fkFormGroup]
	,[fkFormName]
	,[fkFormJoinFormNameFormGroupParent]
	,[fkFormGroupFormCaption]
	,[Copies]
	,[FormOrder]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormJoinFormNameFormGroup]
	,[fkFormGroup]
	,[fkFormName]
	,[fkFormJoinFormNameFormGroupParent]
	,[fkFormGroupFormCaption]
	,[Copies]
	,[FormOrder]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormNameFormGroup', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormNameFormGroup', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table collects records from FormName and FormGroup together.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormNameFormGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormNameFormGroup', @level2type = N'COLUMN', @level2name = N'pkFormJoinFormNameFormGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Form Group', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormNameFormGroup', @level2type = N'COLUMN', @level2name = N'fkFormGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormName', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormNameFormGroup', @level2type = N'COLUMN', @level2name = N'fkFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormGroup to get the group''s parent group', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormNameFormGroup', @level2type = N'COLUMN', @level2name = N'fkFormJoinFormNameFormGroupParent';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated as there is no FormGroupFormCaption table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormNameFormGroup', @level2type = N'COLUMN', @level2name = N'fkFormGroupFormCaption';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'How many copies of this form should be in the form group', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormNameFormGroup', @level2type = N'COLUMN', @level2name = N'Copies';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'In what order should this form display in the group.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormNameFormGroup', @level2type = N'COLUMN', @level2name = N'FormOrder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormNameFormGroup', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormNameFormGroup', @level2type = N'COLUMN', @level2name = N'LUPDate';

