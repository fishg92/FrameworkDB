CREATE TABLE [dbo].[refAnnotationType] (
    [pkRefAnnotationType] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [Name]                VARCHAR (50) NOT NULL,
    [LUPUser]             VARCHAR (50) NULL,
    [LUPDate]             DATETIME     NULL,
    [CreateUser]          VARCHAR (50) NULL,
    [CreateDate]          DATETIME     NULL,
    CONSTRAINT [PK_refAnnotationType] PRIMARY KEY CLUSTERED ([pkRefAnnotationType] ASC)
);


GO
CREATE Trigger [dbo].[tr_refAnnotationTypeAudit_d] On [dbo].[refAnnotationType]
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
From refAnnotationTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkrefAnnotationType] = d.[pkrefAnnotationType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refAnnotationTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkRefAnnotationType]
	,[Name]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkRefAnnotationType]
	,[Name]
From  Deleted
GO
CREATE Trigger [dbo].[tr_refAnnotationTypeAudit_UI] On [dbo].[refAnnotationType]
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

Update refAnnotationType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refAnnotationType dbTable
	Inner Join Inserted i on dbtable.pkrefAnnotationType = i.pkrefAnnotationType
	Left Join Deleted d on d.pkrefAnnotationType = d.pkrefAnnotationType
	Where d.pkrefAnnotationType is null

Update refAnnotationType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refAnnotationType dbTable
	Inner Join Deleted d on dbTable.pkrefAnnotationType = d.pkrefAnnotationType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From refAnnotationTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkrefAnnotationType] = i.[pkrefAnnotationType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refAnnotationTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkRefAnnotationType]
	,[Name]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkRefAnnotationType]
	,[Name]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ref tables are reference tables that are used to populate drop downs, enumerate options, or otherwise provide a (usually) static list of items to the program. In this case, the list is what sort of fields are available to add to forms.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refAnnotationType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refAnnotationType', @level2type = N'COLUMN', @level2name = N'pkRefAnnotationType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the type of form field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refAnnotationType', @level2type = N'COLUMN', @level2name = N'Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refAnnotationType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refAnnotationType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refAnnotationType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refAnnotationType', @level2type = N'COLUMN', @level2name = N'CreateDate';

