CREATE TABLE [dbo].[refAssignmentType] (
    [pkrefAssignmentType] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [Description]         VARCHAR (100) NOT NULL,
    [LUPUser]             VARCHAR (50)  NULL,
    [LUPDate]             DATETIME      NULL,
    [CreateUser]          VARCHAR (50)  NULL,
    [CreateDate]          DATETIME      NULL,
    CONSTRAINT [PK_refAssignmentType] PRIMARY KEY CLUSTERED ([pkrefAssignmentType] ASC)
);


GO
CREATE Trigger [dbo].[tr_refAssignmentTypeAudit_UI] On [dbo].[refAssignmentType]
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

Update refAssignmentType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refAssignmentType dbTable
	Inner Join Inserted i on dbtable.pkrefAssignmentType = i.pkrefAssignmentType
	Left Join Deleted d on d.pkrefAssignmentType = d.pkrefAssignmentType
	Where d.pkrefAssignmentType is null

Update refAssignmentType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refAssignmentType dbTable
	Inner Join Deleted d on dbTable.pkrefAssignmentType = d.pkrefAssignmentType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From refAssignmentTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkrefAssignmentType] = i.[pkrefAssignmentType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refAssignmentTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefAssignmentType]
	,[Description]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkrefAssignmentType]
	,[Description]

From  Inserted
GO
CREATE Trigger [dbo].[tr_refAssignmentTypeAudit_d] On [dbo].[refAssignmentType]
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
From refAssignmentTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkrefAssignmentType] = d.[pkrefAssignmentType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refAssignmentTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefAssignmentType]
	,[Description]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkrefAssignmentType]
	,[Description]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This reference table contains a list of assignment types.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refAssignmentType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refAssignmentType', @level2type = N'COLUMN', @level2name = N'pkrefAssignmentType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the document assignment type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refAssignmentType', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refAssignmentType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refAssignmentType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refAssignmentType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refAssignmentType', @level2type = N'COLUMN', @level2name = N'CreateDate';

