CREATE TABLE [dbo].[JoinTaskDocument] (
    [pkJoinTaskDocument] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkDocument]         VARCHAR (50) NOT NULL,
    [fkTask]             DECIMAL (18) NOT NULL,
    [LUPUser]            VARCHAR (50) NULL,
    [LUPDate]            DATETIME     NULL,
    [CreateUser]         VARCHAR (50) NULL,
    [CreateDate]         DATETIME     NULL,
    CONSTRAINT [PK_JoinTaskDocument] PRIMARY KEY CLUSTERED ([pkJoinTaskDocument] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [fkDocument_fkTask]
    ON [dbo].[JoinTaskDocument]([fkDocument] ASC, [fkTask] ASC);


GO
CREATE NONCLUSTERED INDEX [fkTask_fkDocument]
    ON [dbo].[JoinTaskDocument]([fkTask] ASC, [fkDocument] ASC);


GO
CREATE Trigger [dbo].[tr_JoinTaskDocumentAudit_UI] On [dbo].[JoinTaskDocument]
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

Update JoinTaskDocument
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinTaskDocument dbTable
	Inner Join Inserted i on dbtable.pkJoinTaskDocument = i.pkJoinTaskDocument
	Left Join Deleted d on d.pkJoinTaskDocument = d.pkJoinTaskDocument
	Where d.pkJoinTaskDocument is null

Update JoinTaskDocument
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From JoinTaskDocument dbTable
	Inner Join Deleted d on dbTable.pkJoinTaskDocument = d.pkJoinTaskDocument
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinTaskDocumentAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinTaskDocument] = i.[pkJoinTaskDocument]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinTaskDocumentAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinTaskDocument]
	,[fkDocument]
	,[fkTask]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinTaskDocument]
	,[fkDocument]
	,[fkTask]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinTaskDocumentAudit_d] On [dbo].[JoinTaskDocument]
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
From JoinTaskDocumentAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinTaskDocument] = d.[pkJoinTaskDocument]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinTaskDocumentAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinTaskDocument]
	,[fkDocument]
	,[fkTask]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinTaskDocument]
	,[fkDocument]
	,[fkTask]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This join table links tasks with documents.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskDocument';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskDocument', @level2type = N'COLUMN', @level2name = N'pkJoinTaskDocument';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Document', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskDocument', @level2type = N'COLUMN', @level2name = N'fkDocument';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Task', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskDocument', @level2type = N'COLUMN', @level2name = N'fkTask';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskDocument', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskDocument', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskDocument', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinTaskDocument', @level2type = N'COLUMN', @level2name = N'CreateDate';

