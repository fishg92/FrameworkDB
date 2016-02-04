CREATE TABLE [dbo].[FormQuickListFolderName] (
    [pkFormQuickListFolderName] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [QuickListFolderName]       VARCHAR (255) COLLATE Latin1_General_CS_AS NOT NULL,
    [Description]               VARCHAR (500) NULL,
    [LUPUser]                   VARCHAR (50)  NULL,
    [LUPDate]                   DATETIME      NULL,
    [CreateUser]                VARCHAR (50)  NULL,
    [CreateDate]                DATETIME      NULL,
    CONSTRAINT [PK_FormQuickListFolderName] PRIMARY KEY CLUSTERED ([pkFormQuickListFolderName] ASC)
);


GO
CREATE NONCLUSTERED INDEX [QuickListFolderName]
    ON [dbo].[FormQuickListFolderName]([QuickListFolderName] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_FormQuickListFolderNameAudit_UI] On [dbo].[FormQuickListFolderName]
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

Update FormQuickListFolderName
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormQuickListFolderName dbTable
	Inner Join Inserted i on dbtable.pkFormQuickListFolderName = i.pkFormQuickListFolderName
	Left Join Deleted d on d.pkFormQuickListFolderName = d.pkFormQuickListFolderName
	Where d.pkFormQuickListFolderName is null

Update FormQuickListFolderName
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormQuickListFolderName dbTable
	Inner Join Deleted d on dbTable.pkFormQuickListFolderName = d.pkFormQuickListFolderName
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormQuickListFolderNameAudit dbTable
Inner Join inserted i ON dbTable.[pkFormQuickListFolderName] = i.[pkFormQuickListFolderName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormQuickListFolderNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormQuickListFolderName]
	,[QuickListFolderName]
	,[Description]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormQuickListFolderName]
	,[QuickListFolderName]
	,[Description]

From  Inserted
GO
CREATE Trigger [dbo].[tr_FormQuickListFolderNameAudit_d] On [dbo].[FormQuickListFolderName]
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
From FormQuickListFolderNameAudit dbTable
Inner Join deleted d ON dbTable.[pkFormQuickListFolderName] = d.[pkFormQuickListFolderName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormQuickListFolderNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormQuickListFolderName]
	,[QuickListFolderName]
	,[Description]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormQuickListFolderName]
	,[QuickListFolderName]
	,[Description]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFolderName', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFolderName', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFolderName', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Holds the names of folders in users'' favorites lists', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFolderName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFolderName', @level2type = N'COLUMN', @level2name = N'pkFormQuickListFolderName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Folder name chosen by user', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFolderName', @level2type = N'COLUMN', @level2name = N'QuickListFolderName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Secondary description to further identify the purpose of the folder', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFolderName', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFolderName', @level2type = N'COLUMN', @level2name = N'LUPUser';

