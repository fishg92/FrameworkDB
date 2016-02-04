CREATE TABLE [dbo].[refRoleType] (
    [pkrefRoleType] DECIMAL (18) NOT NULL,
    [Description]   VARCHAR (50) NULL,
    [LUPUser]       VARCHAR (50) NULL,
    [LUPDate]       DATETIME     NULL,
    [CreateUser]    VARCHAR (50) NULL,
    [CreateDate]    DATETIME     NULL,
    CONSTRAINT [PK_refRoleType] PRIMARY KEY CLUSTERED ([pkrefRoleType] ASC)
);


GO
CREATE Trigger [dbo].[tr_refRoleTypeAudit_d] On [dbo].[refRoleType]
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
From refRoleTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkrefRoleType] = d.[pkrefRoleType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refRoleTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefRoleType]
	,[Description]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkrefRoleType]
	,[Description]
From  Deleted
GO
CREATE Trigger [dbo].[tr_refRoleTypeAudit_UI] On [dbo].[refRoleType]
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

Update refRoleType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refRoleType dbTable
	Inner Join Inserted i on dbtable.pkrefRoleType = i.pkrefRoleType
	Left Join Deleted d on d.pkrefRoleType = d.pkrefRoleType
	Where d.pkrefRoleType is null

Update refRoleType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refRoleType dbTable
	Inner Join Deleted d on dbTable.pkrefRoleType = d.pkrefRoleType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From refRoleTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkrefRoleType] = i.[pkrefRoleType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refRoleTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefRoleType]
	,[Description]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkrefRoleType]
	,[Description]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refRoleType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refRoleType', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'A reference table for categorization of user roles', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refRoleType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refRoleType', @level2type = N'COLUMN', @level2name = N'pkrefRoleType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the role type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refRoleType', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refRoleType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refRoleType', @level2type = N'COLUMN', @level2name = N'LUPDate';

