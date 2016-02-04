CREATE TABLE [dbo].[FormJoinFormAnnotationFormAnnotationGroup] (
    [pkFormJoinFormAnnotationFormAnnotationGroup] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkFormAnnotation]                            DECIMAL (18) NOT NULL,
    [fkFormAnnotationGroup]                       DECIMAL (18) NOT NULL,
    [fkForm]                                      DECIMAL (18) NOT NULL,
    [LUPUser]                                     VARCHAR (50) NULL,
    [LUPDate]                                     DATETIME     NULL,
    [CreateUser]                                  VARCHAR (50) NULL,
    [CreateDate]                                  DATETIME     NULL,
    CONSTRAINT [PK_FormJoinFormAnnotationFormAnnotationGroup] PRIMARY KEY CLUSTERED ([pkFormJoinFormAnnotationFormAnnotationGroup] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkForm_fkFormAnnotation]
    ON [dbo].[FormJoinFormAnnotationFormAnnotationGroup]([fkForm] ASC, [fkFormAnnotation] ASC)
    INCLUDE([fkFormAnnotationGroup]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkFormAnnotation_fkFormAnnotationGroup]
    ON [dbo].[FormJoinFormAnnotationFormAnnotationGroup]([fkFormAnnotation] ASC, [fkFormAnnotationGroup] ASC)
    INCLUDE([fkForm]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkFormAnnotationGroup]
    ON [dbo].[FormJoinFormAnnotationFormAnnotationGroup]([fkFormAnnotationGroup] ASC)
    INCLUDE([fkForm], [fkFormAnnotation]);


GO
CREATE Trigger [dbo].[tr_FormJoinFormAnnotationFormAnnotationGroupAudit_d] On [dbo].[FormJoinFormAnnotationFormAnnotationGroup]
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
From FormJoinFormAnnotationFormAnnotationGroupAudit dbTable
Inner Join deleted d ON dbTable.[pkFormJoinFormAnnotationFormAnnotationGroup] = d.[pkFormJoinFormAnnotationFormAnnotationGroup]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormJoinFormAnnotationFormAnnotationGroupAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormJoinFormAnnotationFormAnnotationGroup]
	,[fkFormAnnotation]
	,[fkFormAnnotationGroup]
	,[fkForm]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormJoinFormAnnotationFormAnnotationGroup]
	,[fkFormAnnotation]
	,[fkFormAnnotationGroup]
	,[fkForm]
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormJoinFormAnnotationFormAnnotationGroupAudit_UI] On [dbo].[FormJoinFormAnnotationFormAnnotationGroup]
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

Update FormJoinFormAnnotationFormAnnotationGroup
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormJoinFormAnnotationFormAnnotationGroup dbTable
	Inner Join Inserted i on dbtable.pkFormJoinFormAnnotationFormAnnotationGroup = i.pkFormJoinFormAnnotationFormAnnotationGroup
	Left Join Deleted d on d.pkFormJoinFormAnnotationFormAnnotationGroup = d.pkFormJoinFormAnnotationFormAnnotationGroup
	Where d.pkFormJoinFormAnnotationFormAnnotationGroup is null

Update FormJoinFormAnnotationFormAnnotationGroup
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormJoinFormAnnotationFormAnnotationGroup dbTable
	Inner Join Deleted d on dbTable.pkFormJoinFormAnnotationFormAnnotationGroup = d.pkFormJoinFormAnnotationFormAnnotationGroup
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormJoinFormAnnotationFormAnnotationGroupAudit dbTable
Inner Join inserted i ON dbTable.[pkFormJoinFormAnnotationFormAnnotationGroup] = i.[pkFormJoinFormAnnotationFormAnnotationGroup]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormJoinFormAnnotationFormAnnotationGroupAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormJoinFormAnnotationFormAnnotationGroup]
	,[fkFormAnnotation]
	,[fkFormAnnotationGroup]
	,[fkForm]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormJoinFormAnnotationFormAnnotationGroup]
	,[fkFormAnnotation]
	,[fkFormAnnotationGroup]
	,[fkForm]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table represents a many to many relationship between form fields (in FormAnnotation) and form field groups (FormAnnotationGroup)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormAnnotationFormAnnotationGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number NOTE: This field is a candidate to be replaced by a composite key consisting of fkFormAnnotation, fkFormAnnotationGroup and fkForm', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormAnnotationFormAnnotationGroup', @level2type = N'COLUMN', @level2name = N'pkFormJoinFormAnnotationFormAnnotationGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormAnnotation', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormAnnotationFormAnnotationGroup', @level2type = N'COLUMN', @level2name = N'fkFormAnnotation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormAnnotationGroup', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormAnnotationFormAnnotationGroup', @level2type = N'COLUMN', @level2name = N'fkFormAnnotationGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ForeignKey to Form', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormAnnotationFormAnnotationGroup', @level2type = N'COLUMN', @level2name = N'fkForm';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormAnnotationFormAnnotationGroup', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormAnnotationFormAnnotationGroup', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormAnnotationFormAnnotationGroup', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormAnnotationFormAnnotationGroup', @level2type = N'COLUMN', @level2name = N'CreateDate';

