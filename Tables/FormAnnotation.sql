CREATE TABLE [dbo].[FormAnnotation] (
    [pkFormAnnotation]             DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [fkForm]                       DECIMAL (18)    NOT NULL,
    [AnnotationName]               VARCHAR (100)   NOT NULL,
    [AnnotationFormOrder]          INT             NOT NULL,
    [Page]                         INT             CONSTRAINT [DF_FormAnnotation_Page] DEFAULT ((0)) NOT NULL,
    [Deleted]                      TINYINT         NOT NULL,
    [Mask]                         VARCHAR (50)    NULL,
    [Required]                     BIT             NOT NULL,
    [fkFormComboName]              DECIMAL (18)    CONSTRAINT [DF_Annotation_fkFormComboName] DEFAULT ((0)) NOT NULL,
    [Tag]                          VARCHAR (50)    NULL,
    [fkrefAnnotationType]          DECIMAL (18)    NOT NULL,
    [DefaultText]                  VARCHAR (2000)  NULL,
    [FontName]                     VARCHAR (255)   NULL,
    [FontSize]                     FLOAT (53)      NULL,
    [FontStyle]                    INT             NULL,
    [FontColor]                    VARCHAR (100)   NULL,
    [SingleUse]                    BIT             NULL,
    [LUPUser]                      VARCHAR (50)    NULL,
    [LUPDate]                      DATETIME        NULL,
    [CreateUser]                   VARCHAR (50)    NULL,
    [CreateDate]                   DATETIME        NULL,
    [fkFormAnnotationSharedObject] DECIMAL (18)    NULL,
    [ReadOnly]                     BIT             NULL,
    [Formula]                      VARCHAR (500)   NULL,
    [DefaultValue]                 DECIMAL (18, 5) NULL,
    [fkAutofillViewForQuickName]   DECIMAL (18)    NULL,
    [NewLineAfter]                 BIT             CONSTRAINT [DF__FormAnnot__NewLi__36A26E62] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ANNOTATION] PRIMARY KEY CLUSTERED ([pkFormAnnotation] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkForm]
    ON [dbo].[FormAnnotation]([fkForm] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkFormAnnotationSharedObject]
    ON [dbo].[FormAnnotation]([fkFormAnnotationSharedObject] ASC);


GO
CREATE NONCLUSTERED INDEX [fkFormComboName]
    ON [dbo].[FormAnnotation]([fkFormComboName] ASC);


GO
CREATE NONCLUSTERED INDEX [fkrefAnnotationType]
    ON [dbo].[FormAnnotation]([fkrefAnnotationType] ASC);


GO
CREATE Trigger [dbo].[tr_FormAnnotationAudit_d] On [dbo].[FormAnnotation]
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
From FormAnnotationAudit dbTable
Inner Join deleted d ON dbTable.[pkFormAnnotation] = d.[pkFormAnnotation]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormAnnotationAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormAnnotation]
	,[fkForm]
	,[AnnotationName]
	,[AnnotationFormOrder]
	,[Page]
	,[Deleted]
	,[Mask]
	,[Required]
	,[fkFormComboName]
	,[Tag]
	,[fkrefAnnotationType]
	,[DefaultText]
	,[FontName]
	,[FontSize]
	,[FontStyle]
	,[FontColor]
	,[SingleUse]
	,[fkFormAnnotationSharedObject]
	,[ReadOnly]
	,[Formula]
	,[DefaultValue]
	,[fkAutofillViewForQuickName]
	,[NewLineAfter]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormAnnotation]
	,[fkForm]
	,[AnnotationName]
	,[AnnotationFormOrder]
	,[Page]
	,[Deleted]
	,[Mask]
	,[Required]
	,[fkFormComboName]
	,[Tag]
	,[fkrefAnnotationType]
	,[DefaultText]
	,[FontName]
	,[FontSize]
	,[FontStyle]
	,[FontColor]
	,[SingleUse]
	,[fkFormAnnotationSharedObject]
	,[ReadOnly]
	,[Formula]
	,[DefaultValue]
	,[fkAutofillViewForQuickName]
	,[NewLineAfter]
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormAnnotationAudit_UI] On [dbo].[FormAnnotation]
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

Update FormAnnotation
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormAnnotation dbTable
	Inner Join Inserted i on dbtable.pkFormAnnotation = i.pkFormAnnotation
	Left Join Deleted d on d.pkFormAnnotation = d.pkFormAnnotation
	Where d.pkFormAnnotation is null

Update FormAnnotation
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormAnnotation dbTable
	Inner Join Deleted d on dbTable.pkFormAnnotation = d.pkFormAnnotation
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormAnnotationAudit dbTable
Inner Join inserted i ON dbTable.[pkFormAnnotation] = i.[pkFormAnnotation]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormAnnotationAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormAnnotation]
	,[fkForm]
	,[AnnotationName]
	,[AnnotationFormOrder]
	,[Page]
	,[Deleted]
	,[Mask]
	,[Required]
	,[fkFormComboName]
	,[Tag]
	,[fkrefAnnotationType]
	,[DefaultText]
	,[FontName]
	,[FontSize]
	,[FontStyle]
	,[FontColor]
	,[SingleUse]
	,[fkFormAnnotationSharedObject]
	,[ReadOnly]
	,[Formula]
	,[DefaultValue]
	,[fkAutofillViewForQuickName]
	,[NewLineAfter]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormAnnotation]
	,[fkForm]
	,[AnnotationName]
	,[AnnotationFormOrder]
	,[Page]
	,[Deleted]
	,[Mask]
	,[Required]
	,[fkFormComboName]
	,[Tag]
	,[fkrefAnnotationType]
	,[DefaultText]
	,[FontName]
	,[FontSize]
	,[FontStyle]
	,[FontColor]
	,[SingleUse]
	,[fkFormAnnotationSharedObject]
	,[ReadOnly]
	,[Formula]
	,[DefaultValue]
	,[fkAutofillViewForQuickName]
	,[NewLineAfter]
From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Form annotations are the fields on a form. This table contains those fields along with a link to the form on which they appear.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'pkFormAnnotation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the forms table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'fkForm';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of the field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'AnnotationName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Tab stop order for the fields on a form.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'AnnotationFormOrder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'On what page does this field appear', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'Page';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Virtual deletion for annotations (allowing them to be removed from a form, but maintain their history). 1=Deleted.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'Deleted';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Character mask to display to guide users filling out the field (EG ###-##-#### for SSN)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'Mask';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Boolean indicating whether or not the field is required (1=yes, 0=no)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'Required';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormComboName, a table for drop down lists on a form.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'fkFormComboName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'DEPRICATED: Appears to be a holdover from G2. Candidate for removal.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'Tag';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Annotation type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'fkrefAnnotationType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default value to use in the field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'DefaultText';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Font to use for the form fields.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'FontName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Font size to use for the text in the field.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'FontSize';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Font style (0=normal)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'FontStyle';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Color to use for the font.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'FontColor';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Indicates whether or not the field is single use (fill in once, and the value is locked)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'SingleUse';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormAnnotationSharedObject', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'fkFormAnnotationSharedObject';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Boolean indicating whether or not the field is read only', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'ReadOnly';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The formula for a calculated field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'Formula';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Numeric default value', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'DefaultValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to AutifillViewForQuickName', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'fkAutofillViewForQuickName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'If this field is not empty, and it is being concatenated, then add a new line after it when concatenating up.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotation', @level2type = N'COLUMN', @level2name = N'NewLineAfter';

