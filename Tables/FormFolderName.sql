CREATE TABLE [dbo].[FormFolderName] (
    [pkFormFolderName] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [FolderName]       VARCHAR (255) NOT NULL,
    [Description]      VARCHAR (500) NULL,
    [LUPUser]          VARCHAR (50)  NULL,
    [LUPDate]          DATETIME      NULL,
    [CreateUser]       VARCHAR (50)  NULL,
    [CreateDate]       DATETIME      NULL,
    CONSTRAINT [PK_FormFolderName] PRIMARY KEY CLUSTERED ([pkFormFolderName] ASC)
);


GO
CREATE Trigger [dbo].[tr_FormFolderNameAudit_d] On [dbo].[FormFolderName]
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
From FormFolderNameAudit dbTable
Inner Join deleted d ON dbTable.[pkFormFolderName] = d.[pkFormFolderName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormFolderNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormFolderName]
	,[FolderName]
	,[Description]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormFolderName]
	,[FolderName]
	,[Description]
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormFolderNameAudit_UI] On [dbo].[FormFolderName]
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

Update FormFolderName
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormFolderName dbTable
	Inner Join Inserted i on dbtable.pkFormFolderName = i.pkFormFolderName
	Left Join Deleted d on d.pkFormFolderName = d.pkFormFolderName
	Where d.pkFormFolderName is null

Update FormFolderName
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormFolderName dbTable
	Inner Join Deleted d on dbTable.pkFormFolderName = d.pkFormFolderName
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormFolderNameAudit dbTable
Inner Join inserted i ON dbTable.[pkFormFolderName] = i.[pkFormFolderName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormFolderNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormFolderName]
	,[FolderName]
	,[Description]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormFolderName]
	,[FolderName]
	,[Description]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Table containing the names of folders (Possibly overnormalized)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFolderName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFolderName', @level2type = N'COLUMN', @level2name = N'pkFormFolderName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Folder''s name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFolderName', @level2type = N'COLUMN', @level2name = N'FolderName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Longer description of the folder', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFolderName', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFolderName', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFolderName', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFolderName', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFolderName', @level2type = N'COLUMN', @level2name = N'CreateDate';

