CREATE TABLE [dbo].[FormJoinFormFolderFormGroup] (
    [pkFormJoinFormFolderFormGroup] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkFormFolder]                  DECIMAL (18) NOT NULL,
    [fkFormGroup]                   DECIMAL (18) NOT NULL,
    [LUPUser]                       VARCHAR (50) NULL,
    [LUPDate]                       DATETIME     NULL,
    [CreateUser]                    VARCHAR (50) NULL,
    [CreateDate]                    DATETIME     NULL,
    CONSTRAINT [PK_FormJoinFormFolderFormGroupName] PRIMARY KEY CLUSTERED ([pkFormJoinFormFolderFormGroup] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormFolder_fkFormGroup]
    ON [dbo].[FormJoinFormFolderFormGroup]([fkFormFolder] ASC, [fkFormGroup] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkFormGroup_fkFormFolder]
    ON [dbo].[FormJoinFormFolderFormGroup]([fkFormGroup] ASC, [fkFormFolder] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_FormJoinFormFolderFormGroupAudit_d] On [dbo].[FormJoinFormFolderFormGroup]
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
From FormJoinFormFolderFormGroupAudit dbTable
Inner Join deleted d ON dbTable.[pkFormJoinFormFolderFormGroup] = d.[pkFormJoinFormFolderFormGroup]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormJoinFormFolderFormGroupAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormJoinFormFolderFormGroup]
	,[fkFormFolder]
	,[fkFormGroup]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormJoinFormFolderFormGroup]
	,[fkFormFolder]
	,[fkFormGroup]
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormJoinFormFolderFormGroupAudit_UI] On [dbo].[FormJoinFormFolderFormGroup]
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

Update FormJoinFormFolderFormGroup
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormJoinFormFolderFormGroup dbTable
	Inner Join Inserted i on dbtable.pkFormJoinFormFolderFormGroup = i.pkFormJoinFormFolderFormGroup
	Left Join Deleted d on d.pkFormJoinFormFolderFormGroup = d.pkFormJoinFormFolderFormGroup
	Where d.pkFormJoinFormFolderFormGroup is null

Update FormJoinFormFolderFormGroup
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormJoinFormFolderFormGroup dbTable
	Inner Join Deleted d on dbTable.pkFormJoinFormFolderFormGroup = d.pkFormJoinFormFolderFormGroup
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormJoinFormFolderFormGroupAudit dbTable
Inner Join inserted i ON dbTable.[pkFormJoinFormFolderFormGroup] = i.[pkFormJoinFormFolderFormGroup]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormJoinFormFolderFormGroupAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormJoinFormFolderFormGroup]
	,[fkFormFolder]
	,[fkFormGroup]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormJoinFormFolderFormGroup]
	,[fkFormFolder]
	,[fkFormGroup]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table represents the many to many relationship between for folders and form groups', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormFolderFormGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormFolderFormGroup', @level2type = N'COLUMN', @level2name = N'pkFormJoinFormFolderFormGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign Key to FormFolder', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormFolderFormGroup', @level2type = N'COLUMN', @level2name = N'fkFormFolder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormGroup', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormFolderFormGroup', @level2type = N'COLUMN', @level2name = N'fkFormGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormFolderFormGroup', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormFolderFormGroup', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormFolderFormGroup', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormFolderFormGroup', @level2type = N'COLUMN', @level2name = N'CreateDate';

