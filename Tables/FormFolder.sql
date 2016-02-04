CREATE TABLE [dbo].[FormFolder] (
    [pkFormFolder]     DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkFormFolder]     DECIMAL (18) CONSTRAINT [DF_FormFolder_fkFormFolder] DEFAULT ((0)) NOT NULL,
    [fkFormFolderName] DECIMAL (18) NOT NULL,
    [Hidden]           INT          NULL,
    [LUPUser]          VARCHAR (50) NULL,
    [LUPDate]          DATETIME     NULL,
    [CreateUser]       VARCHAR (50) NULL,
    [CreateDate]       DATETIME     NULL,
    CONSTRAINT [PK_FormFolder] PRIMARY KEY CLUSTERED ([pkFormFolder] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormFolder]
    ON [dbo].[FormFolder]([fkFormFolder] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkFormFolderName]
    ON [dbo].[FormFolder]([fkFormFolderName] ASC);


GO
CREATE Trigger [dbo].[tr_FormFolderAudit_d] On [dbo].[FormFolder]
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
From FormFolderAudit dbTable
Inner Join deleted d ON dbTable.[pkFormFolder] = d.[pkFormFolder]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormFolderAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormFolder]
	,[fkFormFolder]
	,[fkFormFolderName]
	,[Hidden]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormFolder]
	,[fkFormFolder]
	,[fkFormFolderName]
	,[Hidden]
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormFolderAudit_UI] On [dbo].[FormFolder]
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

Update FormFolder
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormFolder dbTable
	Inner Join Inserted i on dbtable.pkFormFolder = i.pkFormFolder
	Left Join Deleted d on d.pkFormFolder = d.pkFormFolder
	Where d.pkFormFolder is null

Update FormFolder
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormFolder dbTable
	Inner Join Deleted d on dbTable.pkFormFolder = d.pkFormFolder
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormFolderAudit dbTable
Inner Join inserted i ON dbTable.[pkFormFolder] = i.[pkFormFolder]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormFolderAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormFolder]
	,[fkFormFolder]
	,[fkFormFolderName]
	,[Hidden]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormFolder]
	,[fkFormFolder]
	,[fkFormFolderName]
	,[Hidden]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key representing a parent for the form folder', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFolder', @level2type = N'COLUMN', @level2name = N'fkFormFolder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormFolderName', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFolder', @level2type = N'COLUMN', @level2name = N'fkFormFolderName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Marks whether or not to hide the folder from the tree view (virtual deletion)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFolder', @level2type = N'COLUMN', @level2name = N'Hidden';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFolder', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFolder', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFolder', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFolder', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains the tree structure for the form folders. It references itself.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFolder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFolder', @level2type = N'COLUMN', @level2name = N'pkFormFolder';

