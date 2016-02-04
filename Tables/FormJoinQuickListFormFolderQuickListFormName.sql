CREATE TABLE [dbo].[FormJoinQuickListFormFolderQuickListFormName] (
    [pkFormJoinQuickListFormFolderQuickListFormName] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkFormQuickListFolder]                          DECIMAL (18) NOT NULL,
    [fkFormQuickListFormName]                        DECIMAL (18) NOT NULL,
    [LUPUser]                                        VARCHAR (50) NULL,
    [LUPDate]                                        DATETIME     NULL,
    [CreateUser]                                     VARCHAR (50) NULL,
    [CreateDate]                                     DATETIME     NULL,
    CONSTRAINT [PK_FormQuickListFormFolderQuickListFormName] PRIMARY KEY CLUSTERED ([pkFormJoinQuickListFormFolderQuickListFormName] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormQuickListFolderName_fkFormQuickListFolder]
    ON [dbo].[FormJoinQuickListFormFolderQuickListFormName]([fkFormQuickListFormName] ASC, [fkFormQuickListFolder] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkFormQuickListFolder_fkFormQuickListFolderName]
    ON [dbo].[FormJoinQuickListFormFolderQuickListFormName]([fkFormQuickListFolder] ASC, [fkFormQuickListFormName] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_FormJoinQuickListFormFolderQuickListFormNameAudit_UI] On [dbo].[FormJoinQuickListFormFolderQuickListFormName]
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

Update FormJoinQuickListFormFolderQuickListFormName
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormJoinQuickListFormFolderQuickListFormName dbTable
	Inner Join Inserted i on dbtable.pkFormJoinQuickListFormFolderQuickListFormName = i.pkFormJoinQuickListFormFolderQuickListFormName
	Left Join Deleted d on d.pkFormJoinQuickListFormFolderQuickListFormName = d.pkFormJoinQuickListFormFolderQuickListFormName
	Where d.pkFormJoinQuickListFormFolderQuickListFormName is null

Update FormJoinQuickListFormFolderQuickListFormName
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormJoinQuickListFormFolderQuickListFormName dbTable
	Inner Join Deleted d on dbTable.pkFormJoinQuickListFormFolderQuickListFormName = d.pkFormJoinQuickListFormFolderQuickListFormName
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormJoinQuickListFormFolderQuickListFormNameAudit dbTable
Inner Join inserted i ON dbTable.[pkFormJoinQuickListFormFolderQuickListFormName] = i.[pkFormJoinQuickListFormFolderQuickListFormName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormJoinQuickListFormFolderQuickListFormNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormJoinQuickListFormFolderQuickListFormName]
	,[fkFormQuickListFolder]
	,[fkFormQuickListFormName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormJoinQuickListFormFolderQuickListFormName]
	,[fkFormQuickListFolder]
	,[fkFormQuickListFormName]

From  Inserted
GO
CREATE Trigger [dbo].[tr_FormJoinQuickListFormFolderQuickListFormNameAudit_d] On [dbo].[FormJoinQuickListFormFolderQuickListFormName]
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
From FormJoinQuickListFormFolderQuickListFormNameAudit dbTable
Inner Join deleted d ON dbTable.[pkFormJoinQuickListFormFolderQuickListFormName] = d.[pkFormJoinQuickListFormFolderQuickListFormName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormJoinQuickListFormFolderQuickListFormNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormJoinQuickListFormFolderQuickListFormName]
	,[fkFormQuickListFolder]
	,[fkFormQuickListFormName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormJoinQuickListFormFolderQuickListFormName]
	,[fkFormQuickListFolder]
	,[fkFormQuickListFormName]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Defines the many-to-many relationship between the FormQuickListFormFolder and FormQuickListFormName tables', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormFolderQuickListFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormFolderQuickListFormName', @level2type = N'COLUMN', @level2name = N'pkFormJoinQuickListFormFolderQuickListFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormQuickListFolder table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormFolderQuickListFormName', @level2type = N'COLUMN', @level2name = N'fkFormQuickListFolder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormQuickListFormName table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormFolderQuickListFormName', @level2type = N'COLUMN', @level2name = N'fkFormQuickListFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormFolderQuickListFormName', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormFolderQuickListFormName', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormFolderQuickListFormName', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinQuickListFormFolderQuickListFormName', @level2type = N'COLUMN', @level2name = N'CreateDate';

