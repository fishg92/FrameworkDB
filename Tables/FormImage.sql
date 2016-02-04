CREATE TABLE [dbo].[FormImage] (
    [pkFormImage]   DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [fkFormName]    DECIMAL (18)    NOT NULL,
    [Image]         VARBINARY (MAX) NOT NULL,
    [FileExtension] VARCHAR (10)    NOT NULL,
    [LUPUser]       VARCHAR (50)    NULL,
    [LUPDate]       DATETIME        NULL,
    [CreateUser]    VARCHAR (50)    NULL,
    [CreateDate]    DATETIME        NULL,
    CONSTRAINT [PK_FormImage] PRIMARY KEY CLUSTERED ([pkFormImage] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormName]
    ON [dbo].[FormImage]([fkFormName] ASC);


GO
CREATE Trigger [dbo].[tr_FormImageAudit_UI] On [dbo].[FormImage]
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

Update FormImage
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormImage dbTable
	Inner Join Inserted i on dbtable.pkFormImage = i.pkFormImage
	Left Join Deleted d on d.pkFormImage = d.pkFormImage
	Where d.pkFormImage is null

Update FormImage
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormImage dbTable
	Inner Join Deleted d on dbTable.pkFormImage = d.pkFormImage
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormImageAudit dbTable
Inner Join inserted i ON dbTable.[pkFormImage] = i.[pkFormImage]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormImageAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormImage]
	,[fkFormName]
	,[Image]
	,[FileExtension]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormImage]
	,[fkFormName]
	,0
	,[FileExtension]

From  Inserted
GO
CREATE Trigger [dbo].[tr_FormImageAudit_d] On [dbo].[FormImage]
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
From FormImageAudit dbTable
Inner Join deleted d ON dbTable.[pkFormImage] = d.[pkFormImage]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormImageAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormImage]
	,[fkFormName]
	,[Image]
	,[FileExtension]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormImage]
	,[fkFormName]
	,[Image]
	,[FileExtension]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the FormName table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormImage', @level2type = N'COLUMN', @level2name = N'fkFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Binary information that is the image file itself', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormImage', @level2type = N'COLUMN', @level2name = N'Image';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'File name extension', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormImage', @level2type = N'COLUMN', @level2name = N'FileExtension';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormImage', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormImage', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormImage', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormImage', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Possibly deprecated, this table stores the image information for various forms as actual binary information', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormImage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormImage', @level2type = N'COLUMN', @level2name = N'pkFormImage';

