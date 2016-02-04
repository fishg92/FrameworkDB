CREATE TABLE [dbo].[FormAnnotationPosition] (
    [pkFormAnnotationPosition] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkFormAnnotation]         DECIMAL (18) NOT NULL,
    [x]                        INT          NOT NULL,
    [y]                        INT          NOT NULL,
    [Width]                    INT          NOT NULL,
    [Height]                   INT          NOT NULL,
    [LUPUser]                  VARCHAR (50) NULL,
    [LUPDate]                  DATETIME     NULL,
    [CreateUser]               VARCHAR (50) NULL,
    [CreateDate]               DATETIME     NULL,
    CONSTRAINT [PK_AnnotationPosition] PRIMARY KEY CLUSTERED ([pkFormAnnotationPosition] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormAnnotation]
    ON [dbo].[FormAnnotationPosition]([fkFormAnnotation] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_FormAnnotationPositionAudit_d] On [dbo].[FormAnnotationPosition]
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
From FormAnnotationPositionAudit dbTable
Inner Join deleted d ON dbTable.[pkFormAnnotationPosition] = d.[pkFormAnnotationPosition]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormAnnotationPositionAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormAnnotationPosition]
	,[fkFormAnnotation]
	,[x]
	,[y]
	,[Width]
	,[Height]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormAnnotationPosition]
	,[fkFormAnnotation]
	,[x]
	,[y]
	,[Width]
	,[Height]
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormAnnotationPositionAudit_UI] On [dbo].[FormAnnotationPosition]
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

Update FormAnnotationPosition
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormAnnotationPosition dbTable
	Inner Join Inserted i on dbtable.pkFormAnnotationPosition = i.pkFormAnnotationPosition
	Left Join Deleted d on d.pkFormAnnotationPosition = d.pkFormAnnotationPosition
	Where d.pkFormAnnotationPosition is null

Update FormAnnotationPosition
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormAnnotationPosition dbTable
	Inner Join Deleted d on dbTable.pkFormAnnotationPosition = d.pkFormAnnotationPosition
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormAnnotationPositionAudit dbTable
Inner Join inserted i ON dbTable.[pkFormAnnotationPosition] = i.[pkFormAnnotationPosition]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormAnnotationPositionAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormAnnotationPosition]
	,[fkFormAnnotation]
	,[x]
	,[y]
	,[Width]
	,[Height]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormAnnotationPosition]
	,[fkFormAnnotation]
	,[x]
	,[y]
	,[Width]
	,[Height]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table tracks the positioning of form fields on a form.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationPosition';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationPosition', @level2type = N'COLUMN', @level2name = N'pkFormAnnotationPosition';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormAnnotation', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationPosition', @level2type = N'COLUMN', @level2name = N'fkFormAnnotation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Position on the x-axis on the form in pixels of the upper left corner', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationPosition', @level2type = N'COLUMN', @level2name = N'x';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Position on the y-axis in pixels of the upper left corner', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationPosition', @level2type = N'COLUMN', @level2name = N'y';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Width of the field in pixels', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationPosition', @level2type = N'COLUMN', @level2name = N'Width';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Height of the field in pixels', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationPosition', @level2type = N'COLUMN', @level2name = N'Height';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationPosition', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationPosition', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationPosition', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormAnnotationPosition', @level2type = N'COLUMN', @level2name = N'CreateDate';

