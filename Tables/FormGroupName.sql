CREATE TABLE [dbo].[FormGroupName] (
    [pkFormGroupName] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [Name]            VARCHAR (255) NOT NULL,
    [LUPUser]         VARCHAR (50)  NULL,
    [LUPDate]         DATETIME      NULL,
    [CreateUser]      VARCHAR (50)  NULL,
    [CreateDate]      DATETIME      NULL,
    CONSTRAINT [PK_FormGroupName] PRIMARY KEY CLUSTERED ([pkFormGroupName] ASC)
);


GO
CREATE Trigger [dbo].[tr_FormGroupNameAudit_UI] On [dbo].[FormGroupName]
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

Update FormGroupName
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormGroupName dbTable
	Inner Join Inserted i on dbtable.pkFormGroupName = i.pkFormGroupName
	Left Join Deleted d on d.pkFormGroupName = d.pkFormGroupName
	Where d.pkFormGroupName is null

Update FormGroupName
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormGroupName dbTable
	Inner Join Deleted d on dbTable.pkFormGroupName = d.pkFormGroupName
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormGroupNameAudit dbTable
Inner Join inserted i ON dbTable.[pkFormGroupName] = i.[pkFormGroupName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormGroupNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormGroupName]
	,[Name]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormGroupName]
	,[Name]

From  Inserted
GO
CREATE Trigger [dbo].[tr_FormGroupNameAudit_d] On [dbo].[FormGroupName]
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
From FormGroupNameAudit dbTable
Inner Join deleted d ON dbTable.[pkFormGroupName] = d.[pkFormGroupName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormGroupNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormGroupName]
	,[Name]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormGroupName]
	,[Name]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table is the (possibly overly normalized) table that stored the group name for various form groups. This is a possible candidate for refactoring', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormGroupName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID Number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormGroupName', @level2type = N'COLUMN', @level2name = N'pkFormGroupName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The name of the group', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormGroupName', @level2type = N'COLUMN', @level2name = N'Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormGroupName', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormGroupName', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormGroupName', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormGroupName', @level2type = N'COLUMN', @level2name = N'CreateDate';

