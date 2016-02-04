CREATE TABLE [dbo].[FormAnnotationValue] (
    [pkFormAnnotationValue]       DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [fkFormRendition]             DECIMAL (18)   NOT NULL,
    [fkFormAnnotation]            DECIMAL (18)   NOT NULL,
    [fkFormAnnotationValueSmall]  DECIMAL (18)   NULL,
    [fkFormAnnotationValueMedium] DECIMAL (18)   NULL,
    [fkFormAnnotationValueLarge]  DECIMAL (18)   NULL,
    [fkFormAnnotationValueHuge]   DECIMAL (18)   NULL,
    [LUPUser]                     VARCHAR (50)   NULL,
    [LUPDate]                     DATETIME       NULL,
    [CreateUser]                  VARCHAR (50)   NULL,
    [CreateDate]                  DATETIME       NULL,
    [AnnotationValue]             VARCHAR (5000) NULL,
    CONSTRAINT [PK_ANNOTATION_VALUE] PRIMARY KEY CLUSTERED ([pkFormAnnotationValue] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormAnnotation]
    ON [dbo].[FormAnnotationValue]([fkFormAnnotation] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkFormRendition]
    ON [dbo].[FormAnnotationValue]([fkFormRendition] ASC)
    INCLUDE([fkFormAnnotation]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_FormAnnotationValueAudit_UI] On [dbo].[FormAnnotationValue]
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

Update FormAnnotationValue
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormAnnotationValue dbTable
	Inner Join Inserted i on dbtable.pkFormAnnotationValue = i.pkFormAnnotationValue
	Left Join Deleted d on d.pkFormAnnotationValue = d.pkFormAnnotationValue
	Where d.pkFormAnnotationValue is null

Update FormAnnotationValue
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormAnnotationValue dbTable
	Inner Join Deleted d on dbTable.pkFormAnnotationValue = d.pkFormAnnotationValue
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormAnnotationValueAudit dbTable
Inner Join inserted i ON dbTable.[pkFormAnnotationValue] = i.[pkFormAnnotationValue]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormAnnotationValueAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormAnnotationValue]
	,[fkFormRendition]
	,[fkFormAnnotation]
	,[fkFormAnnotationValueSmall]
	,[fkFormAnnotationValueMedium]
	,[fkFormAnnotationValueLarge]
	,[fkFormAnnotationValueHuge]
	,[AnnotationValue]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormAnnotationValue]
	,[fkFormRendition]
	,[fkFormAnnotation]
	,[fkFormAnnotationValueSmall]
	,[fkFormAnnotationValueMedium]
	,[fkFormAnnotationValueLarge]
	,[fkFormAnnotationValueHuge]
	,[AnnotationValue]

From  Inserted
GO
CREATE Trigger [dbo].[tr_FormAnnotationValueAudit_d] On [dbo].[FormAnnotationValue]
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
From FormAnnotationValueAudit dbTable
Inner Join deleted d ON dbTable.[pkFormAnnotationValue] = d.[pkFormAnnotationValue]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormAnnotationValueAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormAnnotationValue]
	,[fkFormRendition]
	,[fkFormAnnotation]
	,[fkFormAnnotationValueSmall]
	,[fkFormAnnotationValueMedium]
	,[fkFormAnnotationValueLarge]
	,[fkFormAnnotationValueHuge]
	,[AnnotationValue]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormAnnotationValue]
	,[fkFormRendition]
	,[fkFormAnnotation]
	,[fkFormAnnotationValueSmall]
	,[fkFormAnnotationValueMedium]
	,[fkFormAnnotationValueLarge]
	,[fkFormAnnotationValueHuge]
	,[AnnotationValue]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stored the values of fields in any instance of a form. In addition, it stores what those values have been historically, across different renditions of the form. ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationValue', @level2type = N'COLUMN', @level2name = N'pkFormAnnotationValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to retrieve form renditions', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationValue', @level2type = N'COLUMN', @level2name = N'fkFormRendition';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the FormAnnotation table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationValue', @level2type = N'COLUMN', @level2name = N'fkFormAnnotation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'DEPRECATED', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationValue', @level2type = N'COLUMN', @level2name = N'fkFormAnnotationValueSmall';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'DEPRECATED', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationValue', @level2type = N'COLUMN', @level2name = N'fkFormAnnotationValueMedium';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'DEPRECATED', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationValue', @level2type = N'COLUMN', @level2name = N'fkFormAnnotationValueLarge';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'DEPRECATED', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationValue', @level2type = N'COLUMN', @level2name = N'fkFormAnnotationValueHuge';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationValue', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationValue', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationValue', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationValue', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The actual value of the annotation. This should probably be changed to a varchar(MAX) in the future', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationValue', @level2type = N'COLUMN', @level2name = N'AnnotationValue';

