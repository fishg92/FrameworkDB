CREATE TABLE [dbo].[FormJoinFormFolderFormName] (
    [pkFormJoinFormFolderFormName] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkFormFolder]                 DECIMAL (18) NOT NULL,
    [fkFormName]                   DECIMAL (18) NOT NULL,
    [LUPUser]                      VARCHAR (50) NULL,
    [LUPDate]                      DATETIME     NULL,
    [CreateUser]                   VARCHAR (50) NULL,
    [CreateDate]                   DATETIME     NULL,
    CONSTRAINT [PK_FormJoinFormFolderFormName] PRIMARY KEY CLUSTERED ([pkFormJoinFormFolderFormName] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormFolder_fkFormName]
    ON [dbo].[FormJoinFormFolderFormName]([fkFormFolder] ASC, [fkFormName] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkFormName_fkFormFolder]
    ON [dbo].[FormJoinFormFolderFormName]([fkFormName] ASC, [fkFormFolder] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_FormJoinFormFolderFormNameAudit_d] On [dbo].[FormJoinFormFolderFormName]
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
From FormJoinFormFolderFormNameAudit dbTable
Inner Join deleted d ON dbTable.[pkFormJoinFormFolderFormName] = d.[pkFormJoinFormFolderFormName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormJoinFormFolderFormNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormJoinFormFolderFormName]
	,[fkFormFolder]
	,[fkFormName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormJoinFormFolderFormName]
	,[fkFormFolder]
	,[fkFormName]
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormJoinFormFolderFormNameAudit_UI] On [dbo].[FormJoinFormFolderFormName]
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

Update FormJoinFormFolderFormName
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormJoinFormFolderFormName dbTable
	Inner Join Inserted i on dbtable.pkFormJoinFormFolderFormName = i.pkFormJoinFormFolderFormName
	Left Join Deleted d on d.pkFormJoinFormFolderFormName = d.pkFormJoinFormFolderFormName
	Where d.pkFormJoinFormFolderFormName is null

Update FormJoinFormFolderFormName
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormJoinFormFolderFormName dbTable
	Inner Join Deleted d on dbTable.pkFormJoinFormFolderFormName = d.pkFormJoinFormFolderFormName
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormJoinFormFolderFormNameAudit dbTable
Inner Join inserted i ON dbTable.[pkFormJoinFormFolderFormName] = i.[pkFormJoinFormFolderFormName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormJoinFormFolderFormNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormJoinFormFolderFormName]
	,[fkFormFolder]
	,[fkFormName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormJoinFormFolderFormName]
	,[fkFormFolder]
	,[fkFormName]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table represents the relationship between forms folders and form names.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormFolderFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormFolderFormName', @level2type = N'COLUMN', @level2name = N'pkFormJoinFormFolderFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the FormFolder table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormFolderFormName', @level2type = N'COLUMN', @level2name = N'fkFormFolder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the FormName table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormFolderFormName', @level2type = N'COLUMN', @level2name = N'fkFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormFolderFormName', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormFolderFormName', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormFolderFormName', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormFolderFormName', @level2type = N'COLUMN', @level2name = N'CreateDate';

