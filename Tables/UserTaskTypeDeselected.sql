CREATE TABLE [dbo].[UserTaskTypeDeselected] (
    [pkUserTaskTypeDeselected] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]        DECIMAL (18) NOT NULL,
    [fkrefTaskType]            DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_UserTaskTypeDeselected] PRIMARY KEY CLUSTERED ([pkUserTaskTypeDeselected] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser_fkrefTaskType]
    ON [dbo].[UserTaskTypeDeselected]([fkApplicationUser] ASC, [fkrefTaskType] ASC);


GO
CREATE NONCLUSTERED INDEX [fkrefTaskType]
    ON [dbo].[UserTaskTypeDeselected]([fkrefTaskType] ASC);


GO
CREATE Trigger [dbo].[tr_UserTaskTypeDeselectedAudit_d] On [dbo].[UserTaskTypeDeselected]
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
From UserTaskTypeDeselectedAudit dbTable
Inner Join deleted d ON dbTable.[pkUserTaskTypeDeselected] = d.[pkUserTaskTypeDeselected]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into UserTaskTypeDeselectedAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkUserTaskTypeDeselected]
	,[fkApplicationUser]
	,[fkrefTaskType]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkUserTaskTypeDeselected]
	,[fkApplicationUser]
	,[fkrefTaskType]
From  Deleted
GO
CREATE Trigger [dbo].[tr_UserTaskTypeDeselectedAudit_UI] On [dbo].[UserTaskTypeDeselected]
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


--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From UserTaskTypeDeselectedAudit dbTable
Inner Join inserted i ON dbTable.[pkUserTaskTypeDeselected] = i.[pkUserTaskTypeDeselected]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into UserTaskTypeDeselectedAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkUserTaskTypeDeselected]
	,[fkApplicationUser]
	,[fkrefTaskType]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkUserTaskTypeDeselected]
	,[fkApplicationUser]
	,[fkrefTaskType]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Task types that are not associated with a user. By choosing to store the deselected types, new types are automatically added to user''s view when they are added.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserTaskTypeDeselected';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, self-incrementing ID as primary key. Note: this key, like many PK''s for many-to-many relationship tables, can potentially be refactored to be the composite of the two foreign keys', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserTaskTypeDeselected', @level2type = N'COLUMN', @level2name = N'pkUserTaskTypeDeselected';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserTaskTypeDeselected', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to RefTaskType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserTaskTypeDeselected', @level2type = N'COLUMN', @level2name = N'fkrefTaskType';

