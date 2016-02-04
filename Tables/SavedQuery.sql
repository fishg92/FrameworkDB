CREATE TABLE [dbo].[SavedQuery] (
    [pkSavedQuery]      DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser] DECIMAL (18)  NOT NULL,
    [QueryName]         VARCHAR (255) NOT NULL,
    [ExpirationDate]    SMALLDATETIME NULL,
    [LUPUser]           VARCHAR (50)  NULL,
    [LUPDate]           DATETIME      NULL,
    [CreateUser]        VARCHAR (50)  NULL,
    [CreateDate]        DATETIME      NULL,
    [Notes]             VARCHAR (500) CONSTRAINT [DF_SavedQuery_Notes] DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_SavedQuery] PRIMARY KEY CLUSTERED ([pkSavedQuery] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser_ExpirationDate]
    ON [dbo].[SavedQuery]([fkApplicationUser] ASC, [ExpirationDate] ASC)
    INCLUDE([QueryName]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_SavedQueryAudit_UI] On [dbo].[SavedQuery]
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

Update SavedQuery
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From SavedQuery dbTable
	Inner Join Inserted i on dbtable.pkSavedQuery = i.pkSavedQuery
	Left Join Deleted d on d.pkSavedQuery = d.pkSavedQuery
	Where d.pkSavedQuery is null

Update SavedQuery
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From SavedQuery dbTable
	Inner Join Deleted d on dbTable.pkSavedQuery = d.pkSavedQuery
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From SavedQueryAudit dbTable
Inner Join inserted i ON dbTable.[pkSavedQuery] = i.[pkSavedQuery]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into SavedQueryAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkSavedQuery]
	,[fkApplicationUser]
	,[QueryName]
	,[ExpirationDate]
	,[Notes]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkSavedQuery]
	,[fkApplicationUser]
	,[QueryName]
	,[ExpirationDate]
	,[Notes]

From  Inserted
GO
CREATE Trigger [dbo].[tr_SavedQueryAudit_d] On [dbo].[SavedQuery]
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
From SavedQueryAudit dbTable
Inner Join deleted d ON dbTable.[pkSavedQuery] = d.[pkSavedQuery]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into SavedQueryAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkSavedQuery]
	,[fkApplicationUser]
	,[QueryName]
	,[ExpirationDate]
	,[Notes]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkSavedQuery]
	,[fkApplicationUser]
	,[QueryName]
	,[ExpirationDate]
	,[Notes]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores information about saved queries in Pilot to find specific types of documents.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQuery';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQuery', @level2type = N'COLUMN', @level2name = N'pkSavedQuery';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Application User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQuery', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of the saved query', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQuery', @level2type = N'COLUMN', @level2name = N'QueryName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date that the saved query should be removed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQuery', @level2type = N'COLUMN', @level2name = N'ExpirationDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQuery', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQuery', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQuery', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQuery', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'General descriptino of the query', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SavedQuery', @level2type = N'COLUMN', @level2name = N'Notes';

