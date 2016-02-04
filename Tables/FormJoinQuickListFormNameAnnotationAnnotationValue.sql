CREATE TABLE [dbo].[FormJoinQuickListFormNameAnnotationAnnotationValue] (
    [pkFormJoinQuickListFormNameAnnotationAnnotationValue] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkQuickListFormName]                                  DECIMAL (18)  NOT NULL,
    [fkFormAnnotation]                                     DECIMAL (18)  NOT NULL,
    [fkAnnotationValueSmall]                               DECIMAL (18)  NULL,
    [fkAnnotationValueMedium]                              DECIMAL (18)  NULL,
    [fkAnnotationValueLarge]                               DECIMAL (18)  NULL,
    [fkAnnotationValueHuge]                                DECIMAL (18)  NULL,
    [LUPUser]                                              VARCHAR (50)  NULL,
    [LUPDate]                                              DATETIME      NULL,
    [CreateUser]                                           VARCHAR (50)  NULL,
    [CreateDate]                                           DATETIME      NULL,
    [AnnotationValue]                                      VARCHAR (MAX) NULL,
    CONSTRAINT [PK_FormJoinQuickListFormNameAnnotationAnnotationValue] PRIMARY KEY CLUSTERED ([pkFormJoinQuickListFormNameAnnotationAnnotationValue] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkQuickListFormName_fkFormAnnotation]
    ON [dbo].[FormJoinQuickListFormNameAnnotationAnnotationValue]([fkQuickListFormName] ASC, [fkFormAnnotation] ASC)
    INCLUDE([fkAnnotationValueHuge], [fkAnnotationValueLarge], [fkAnnotationValueMedium], [fkAnnotationValueSmall]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkFormAnnotation]
    ON [dbo].[FormJoinQuickListFormNameAnnotationAnnotationValue]([fkFormAnnotation] ASC)
    INCLUDE([fkQuickListFormName]);


GO
CREATE Trigger [dbo].[tr_FormJoinQuickListFormNameAnnotationAnnotationValueAudit_UI] On [dbo].[FormJoinQuickListFormNameAnnotationAnnotationValue]
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

Update FormJoinQuickListFormNameAnnotationAnnotationValue
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormJoinQuickListFormNameAnnotationAnnotationValue dbTable
	Inner Join Inserted i on dbtable.pkFormJoinQuickListFormNameAnnotationAnnotationValue = i.pkFormJoinQuickListFormNameAnnotationAnnotationValue
	Left Join Deleted d on d.pkFormJoinQuickListFormNameAnnotationAnnotationValue = d.pkFormJoinQuickListFormNameAnnotationAnnotationValue
	Where d.pkFormJoinQuickListFormNameAnnotationAnnotationValue is null

Update FormJoinQuickListFormNameAnnotationAnnotationValue
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormJoinQuickListFormNameAnnotationAnnotationValue dbTable
	Inner Join Deleted d on dbTable.pkFormJoinQuickListFormNameAnnotationAnnotationValue = d.pkFormJoinQuickListFormNameAnnotationAnnotationValue
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormJoinQuickListFormNameAnnotationAnnotationValueAudit dbTable
Inner Join inserted i ON dbTable.[pkFormJoinQuickListFormNameAnnotationAnnotationValue] = i.[pkFormJoinQuickListFormNameAnnotationAnnotationValue]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormJoinQuickListFormNameAnnotationAnnotationValueAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormJoinQuickListFormNameAnnotationAnnotationValue]
	,[fkQuickListFormName]
	,[fkFormAnnotation]
	,[fkAnnotationValueSmall]
	,[fkAnnotationValueMedium]
	,[fkAnnotationValueLarge]
	,[fkAnnotationValueHuge]
	,[AnnotationValue]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormJoinQuickListFormNameAnnotationAnnotationValue]
	,[fkQuickListFormName]
	,[fkFormAnnotation]
	,[fkAnnotationValueSmall]
	,[fkAnnotationValueMedium]
	,[fkAnnotationValueLarge]
	,[fkAnnotationValueHuge]
	,[AnnotationValue]

From  Inserted
GO
CREATE Trigger [dbo].[tr_FormJoinQuickListFormNameAnnotationAnnotationValueAudit_d] On [dbo].[FormJoinQuickListFormNameAnnotationAnnotationValue]
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
From FormJoinQuickListFormNameAnnotationAnnotationValueAudit dbTable
Inner Join deleted d ON dbTable.[pkFormJoinQuickListFormNameAnnotationAnnotationValue] = d.[pkFormJoinQuickListFormNameAnnotationAnnotationValue]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormJoinQuickListFormNameAnnotationAnnotationValueAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormJoinQuickListFormNameAnnotationAnnotationValue]
	,[fkQuickListFormName]
	,[fkFormAnnotation]
	,[fkAnnotationValueSmall]
	,[fkAnnotationValueMedium]
	,[fkAnnotationValueLarge]
	,[fkAnnotationValueHuge]
	,[AnnotationValue]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormJoinQuickListFormNameAnnotationAnnotationValue]
	,[fkQuickListFormName]
	,[fkFormAnnotation]
	,[fkAnnotationValueSmall]
	,[fkAnnotationValueMedium]
	,[fkAnnotationValueLarge]
	,[fkAnnotationValueHuge]
	,[AnnotationValue]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Defines the many-to-many relationship between FormQuickListFormName and FormAnnotation tables', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormNameAnnotationAnnotationValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormNameAnnotationAnnotationValue', @level2type = N'COLUMN', @level2name = N'pkFormJoinQuickListFormNameAnnotationAnnotationValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to QuickListFormName table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormNameAnnotationAnnotationValue', @level2type = N'COLUMN', @level2name = N'fkQuickListFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormAnnotation table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormNameAnnotationAnnotationValue', @level2type = N'COLUMN', @level2name = N'fkFormAnnotation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated field, no longer used', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormNameAnnotationAnnotationValue', @level2type = N'COLUMN', @level2name = N'fkAnnotationValueSmall';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated field, no longer used', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormNameAnnotationAnnotationValue', @level2type = N'COLUMN', @level2name = N'fkAnnotationValueMedium';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated field, no longer used', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormNameAnnotationAnnotationValue', @level2type = N'COLUMN', @level2name = N'fkAnnotationValueLarge';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated field, no longer used', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormNameAnnotationAnnotationValue', @level2type = N'COLUMN', @level2name = N'fkAnnotationValueHuge';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormNameAnnotationAnnotationValue', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormNameAnnotationAnnotationValue', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormNameAnnotationAnnotationValue', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormNameAnnotationAnnotationValue', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Value of the annotation', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormNameAnnotationAnnotationValue', @level2type = N'COLUMN', @level2name = N'AnnotationValue';

