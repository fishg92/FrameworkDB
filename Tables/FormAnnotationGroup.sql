CREATE TABLE [dbo].[FormAnnotationGroup] (
    [pkFormAnnotationGroup]  DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [Name]                   VARCHAR (50)  NOT NULL,
    [Description]            VARCHAR (250) NULL,
    [Type]                   INT           NOT NULL,
    [LUPUser]                VARCHAR (50)  NULL,
    [LUPDate]                DATETIME      NULL,
    [CreateUser]             VARCHAR (50)  NULL,
    [CreateDate]             DATETIME      NULL,
    [fkAutofillDataSource]   DECIMAL (18)  NULL,
    [UseAutofillForIndexing] BIT           NULL,
    CONSTRAINT [PK_AnnotationGroup] PRIMARY KEY CLUSTERED ([pkFormAnnotationGroup] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkAutofillDataSource]
    ON [dbo].[FormAnnotationGroup]([fkAutofillDataSource] ASC);


GO
CREATE Trigger [dbo].[tr_FormAnnotationGroupAudit_UI] On [dbo].[FormAnnotationGroup]
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

Update FormAnnotationGroup
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormAnnotationGroup dbTable
	Inner Join Inserted i on dbtable.pkFormAnnotationGroup = i.pkFormAnnotationGroup
	Left Join Deleted d on d.pkFormAnnotationGroup = d.pkFormAnnotationGroup
	Where d.pkFormAnnotationGroup is null

Update FormAnnotationGroup
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormAnnotationGroup dbTable
	Inner Join Deleted d on dbTable.pkFormAnnotationGroup = d.pkFormAnnotationGroup
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormAnnotationGroupAudit dbTable
Inner Join inserted i ON dbTable.[pkFormAnnotationGroup] = i.[pkFormAnnotationGroup]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormAnnotationGroupAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormAnnotationGroup]
	,[Name]
	,[Description]
	,[Type]
	,[fkAutofillDataSource]
	,[UseAutofillForIndexing]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormAnnotationGroup]
	,[Name]
	,[Description]
	,[Type]
	,[fkAutofillDataSource]
	,[UseAutofillForIndexing]

From  Inserted
GO
CREATE Trigger [dbo].[tr_FormAnnotationGroupAudit_d] On [dbo].[FormAnnotationGroup]
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
From FormAnnotationGroupAudit dbTable
Inner Join deleted d ON dbTable.[pkFormAnnotationGroup] = d.[pkFormAnnotationGroup]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormAnnotationGroupAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormAnnotationGroup]
	,[Name]
	,[Description]
	,[Type]
	,[fkAutofillDataSource]
	,[UseAutofillForIndexing]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormAnnotationGroup]
	,[Name]
	,[Description]
	,[Type]
	,[fkAutofillDataSource]
	,[UseAutofillForIndexing]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Fields on a form can be gathered into groups for use with autofill or concatenation. ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationGroup', @level2type = N'COLUMN', @level2name = N'pkFormAnnotationGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of the group', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationGroup', @level2type = N'COLUMN', @level2name = N'Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Longer description for when the name isn''t self-explainatory', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationGroup', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Integer indicating the type of grouping (Concatention group, autofill group, etc.)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationGroup', @level2type = N'COLUMN', @level2name = N'Type';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationGroup', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationGroup', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationGroup', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationGroup', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the AutofillDataSource table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationGroup', @level2type = N'COLUMN', @level2name = N'fkAutofillDataSource';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Whether or not to index the field using autofill', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationGroup', @level2type = N'COLUMN', @level2name = N'UseAutofillForIndexing';

