CREATE TABLE [dbo].[DocumentDipFolder] (
    [pkDocumentDipFolder] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkApplication]       DECIMAL (18)  NOT NULL,
    [dipFolderPath]       VARCHAR (500) NOT NULL,
    [LUPUser]             VARCHAR (50)  NULL,
    [LUPDate]             DATETIME      NULL,
    [CreateUser]          VARCHAR (50)  NULL,
    [CreateDate]          DATETIME      NULL,
    CONSTRAINT [PK_DocumentDipFolder] PRIMARY KEY CLUSTERED ([pkDocumentDipFolder] ASC)
);


GO
CREATE Trigger [dbo].[tr_DocumentDipFolderAudit_d] On [dbo].[DocumentDipFolder]
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
From DocumentDipFolderAudit dbTable
Inner Join deleted d ON dbTable.[pkDocumentDipFolder] = d.[pkDocumentDipFolder]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into DocumentDipFolderAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkDocumentDipFolder]
	,[fkApplication]
	,[dipFolderPath]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkDocumentDipFolder]
	,[fkApplication]
	,[dipFolderPath]
From  Deleted
GO
CREATE Trigger [dbo].[tr_DocumentDipFolderAudit_UI] On [dbo].[DocumentDipFolder]
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

Update DocumentDipFolder
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From DocumentDipFolder dbTable
	Inner Join Inserted i on dbtable.pkDocumentDipFolder = i.pkDocumentDipFolder
	Left Join Deleted d on d.pkDocumentDipFolder = d.pkDocumentDipFolder
	Where d.pkDocumentDipFolder is null

Update DocumentDipFolder
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From DocumentDipFolder dbTable
	Inner Join Deleted d on dbTable.pkDocumentDipFolder = d.pkDocumentDipFolder
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From DocumentDipFolderAudit dbTable
Inner Join inserted i ON dbTable.[pkDocumentDipFolder] = i.[pkDocumentDipFolder]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into DocumentDipFolderAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkDocumentDipFolder]
	,[fkApplication]
	,[dipFolderPath]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkDocumentDipFolder]
	,[fkApplication]
	,[dipFolderPath]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Stores file paths used by the OnBase Document Import Processor', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentDipFolder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentDipFolder', @level2type = N'COLUMN', @level2name = N'pkDocumentDipFolder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the application table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentDipFolder', @level2type = N'COLUMN', @level2name = N'fkApplication';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Path for the DIP folders to use for processing documents.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentDipFolder', @level2type = N'COLUMN', @level2name = N'dipFolderPath';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentDipFolder', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentDipFolder', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentDipFolder', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentDipFolder', @level2type = N'COLUMN', @level2name = N'CreateDate';

