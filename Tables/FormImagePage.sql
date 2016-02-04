CREATE TABLE [dbo].[FormImagePage] (
    [pkFormImagePage] DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [fkFormName]      DECIMAL (18)    NOT NULL,
    [PageNumber]      INT             NOT NULL,
    [ImageData]       VARBINARY (MAX) NOT NULL,
    [FileExtension]   VARCHAR (50)    NOT NULL,
    CONSTRAINT [PK_FormImagePage] PRIMARY KEY CLUSTERED ([pkFormImagePage] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormName]
    ON [dbo].[FormImagePage]([fkFormName] ASC);


GO
CREATE Trigger [dbo].[tr_FormImagePageAudit_d] On [dbo].[FormImagePage]
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
From FormImagePageAudit dbTable
Inner Join deleted d ON dbTable.[pkFormImagePage] = d.[pkFormImagePage]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormImagePageAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormImagePage]
	,[fkFormName]
	,[PageNumber]
	,[ImageData]
	,[FileExtension]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormImagePage]
	,[fkFormName]
	,[PageNumber]
	,[ImageData]
	,[FileExtension]
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormImagePageAudit_UI] On [dbo].[FormImagePage]
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


--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormImagePageAudit dbTable
Inner Join inserted i ON dbTable.[pkFormImagePage] = i.[pkFormImagePage]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormImagePageAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormImagePage]
	,[fkFormName]
	,[PageNumber]
	,[ImageData]
	,[FileExtension]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormImagePage]
	,[fkFormName]
	,[PageNumber]
	,0
	,[FileExtension]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains the images for each page of a form. This appears to have replaced FormImage.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormImagePage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormImagePage', @level2type = N'COLUMN', @level2name = N'pkFormImagePage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the Form Name table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormImagePage', @level2type = N'COLUMN', @level2name = N'fkFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Page number for the image', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormImagePage', @level2type = N'COLUMN', @level2name = N'PageNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Binary that contains the image data', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormImagePage', @level2type = N'COLUMN', @level2name = N'ImageData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'File extension for the ImageData binary (indicating file type)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormImagePage', @level2type = N'COLUMN', @level2name = N'FileExtension';

