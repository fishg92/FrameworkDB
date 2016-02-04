CREATE TABLE [dbo].[FormQuickListFolder] (
    [pkFormQuickListFolder]     DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkFormQuickListFolder]     DECIMAL (18) NOT NULL,
    [fkFormUser]                DECIMAL (18) NOT NULL,
    [fkFormQuickListFolderName] DECIMAL (18) NOT NULL,
    [DeleteOnFinish]            BIT          NULL,
    [LUPUser]                   VARCHAR (50) NULL,
    [LUPDate]                   DATETIME     NULL,
    [CreateUser]                VARCHAR (50) NULL,
    [CreateDate]                DATETIME     NULL,
    CONSTRAINT [PK_FormQuickListFolder] PRIMARY KEY CLUSTERED ([pkFormQuickListFolder] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormQuickListFolder_fkFormUser]
    ON [dbo].[FormQuickListFolder]([fkFormQuickListFolder] ASC, [fkFormUser] ASC)
    INCLUDE([fkFormQuickListFolderName]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkFormUser_fkFormQuickListFolder]
    ON [dbo].[FormQuickListFolder]([fkFormUser] ASC, [fkFormQuickListFolder] ASC)
    INCLUDE([fkFormQuickListFolderName]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkFormQuickListFolderName]
    ON [dbo].[FormQuickListFolder]([fkFormQuickListFolderName] ASC);


GO
CREATE Trigger [dbo].[tr_FormQuickListFolderAudit_UI] On [dbo].[FormQuickListFolder]
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

Update FormQuickListFolder
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormQuickListFolder dbTable
	Inner Join Inserted i on dbtable.pkFormQuickListFolder = i.pkFormQuickListFolder
	Left Join Deleted d on d.pkFormQuickListFolder = d.pkFormQuickListFolder
	Where d.pkFormQuickListFolder is null

Update FormQuickListFolder
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormQuickListFolder dbTable
	Inner Join Deleted d on dbTable.pkFormQuickListFolder = d.pkFormQuickListFolder
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormQuickListFolderAudit dbTable
Inner Join inserted i ON dbTable.[pkFormQuickListFolder] = i.[pkFormQuickListFolder]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormQuickListFolderAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormQuickListFolder]
	,[fkFormQuickListFolder]
	,[fkFormUser]
	,[fkFormQuickListFolderName]
	,[DeleteOnFinish]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormQuickListFolder]
	,[fkFormQuickListFolder]
	,[fkFormUser]
	,[fkFormQuickListFolderName]
	,[DeleteOnFinish]

From  Inserted
GO
CREATE Trigger [dbo].[tr_FormQuickListFolderAudit_d] On [dbo].[FormQuickListFolder]
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
From FormQuickListFolderAudit dbTable
Inner Join deleted d ON dbTable.[pkFormQuickListFolder] = d.[pkFormQuickListFolder]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormQuickListFolderAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormQuickListFolder]
	,[fkFormQuickListFolder]
	,[fkFormUser]
	,[fkFormQuickListFolderName]
	,[DeleteOnFinish]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormQuickListFolder]
	,[fkFormQuickListFolder]
	,[fkFormUser]
	,[fkFormQuickListFolderName]
	,[DeleteOnFinish]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Describes the hierarchial relationship of each user''s personal QuickList (favorites) in Forms', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFolder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFolder', @level2type = N'COLUMN', @level2name = N'pkFormQuickListFolder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Self-join foreign key to this folder''s parent folder', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFolder', @level2type = N'COLUMN', @level2name = N'fkFormQuickListFolder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFolder', @level2type = N'COLUMN', @level2name = N'fkFormUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormQuickListFolderName table, where the actual name of the folder is stored.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFolder', @level2type = N'COLUMN', @level2name = N'fkFormQuickListFolderName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Designates this folder as temporary to be automatically deleted when the forms in the folder are finished.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFolder', @level2type = N'COLUMN', @level2name = N'DeleteOnFinish';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFolder', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFolder', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFolder', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFolder', @level2type = N'COLUMN', @level2name = N'CreateDate';

