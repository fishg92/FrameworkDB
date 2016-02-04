CREATE TABLE [dbo].[FormPrefillPriorityAnnotation] (
    [pkFormPrefillPriorityAnnotation] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [KeywordName]                     VARCHAR (200) NOT NULL,
    [Position]                        INT           NOT NULL,
    [LUPUser]                         VARCHAR (50)  NULL,
    [LUPDate]                         DATETIME      NULL,
    [CreateUser]                      VARCHAR (50)  NULL,
    [CreateDate]                      DATETIME      NULL,
    CONSTRAINT [PK_FormPrefillPriorityAnnotation] PRIMARY KEY CLUSTERED ([pkFormPrefillPriorityAnnotation] ASC)
);


GO
CREATE Trigger [dbo].[tr_FormPrefillPriorityAnnotationAudit_d] On [dbo].[FormPrefillPriorityAnnotation]
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
From FormPrefillPriorityAnnotationAudit dbTable
Inner Join deleted d ON dbTable.[pkFormPrefillPriorityAnnotation] = d.[pkFormPrefillPriorityAnnotation]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormPrefillPriorityAnnotationAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormPrefillPriorityAnnotation]
	,[KeywordName]
	,[Position]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormPrefillPriorityAnnotation]
	,[KeywordName]
	,[Position]
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormPrefillPriorityAnnotationAudit_ui] On [dbo].[FormPrefillPriorityAnnotation]
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

Update FormPrefillPriorityAnnotation
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormPrefillPriorityAnnotation dbTable
	Inner Join Inserted i on dbtable.pkFormPrefillPriorityAnnotation = i.pkFormPrefillPriorityAnnotation
	Left Join Deleted d on d.pkFormPrefillPriorityAnnotation = d.pkFormPrefillPriorityAnnotation
	Where d.pkFormPrefillPriorityAnnotation is null

Update FormPrefillPriorityAnnotation
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormPrefillPriorityAnnotation dbTable
	Inner Join Deleted d on dbTable.pkFormPrefillPriorityAnnotation = d.pkFormPrefillPriorityAnnotation
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormPrefillPriorityAnnotationAudit dbTable
Inner Join inserted i ON dbTable.[pkFormPrefillPriorityAnnotation] = i.[pkFormPrefillPriorityAnnotation]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormPrefillPriorityAnnotationAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormPrefillPriorityAnnotation]
	,[KeywordName]
	,[Position]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormPrefillPriorityAnnotation]
	,[KeywordName]
	,[Position]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table tracks the different quickname forms that are defined for users.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPrefillPriorityAnnotation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPrefillPriorityAnnotation', @level2type = N'COLUMN', @level2name = N'pkFormPrefillPriorityAnnotation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Pre-defined autofill form field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPrefillPriorityAnnotation', @level2type = N'COLUMN', @level2name = N'KeywordName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Where to show it in the list of pre-defined form fields (quicknames)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPrefillPriorityAnnotation', @level2type = N'COLUMN', @level2name = N'Position';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPrefillPriorityAnnotation', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPrefillPriorityAnnotation', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPrefillPriorityAnnotation', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPrefillPriorityAnnotation', @level2type = N'COLUMN', @level2name = N'CreateDate';

