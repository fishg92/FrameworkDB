CREATE TABLE [dbo].[refTaskCategory] (
    [pkrefTaskCategory]         DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkrefTaskCategoryParent]   DECIMAL (18) NOT NULL,
    [CategoryName]              VARCHAR (50) NOT NULL,
    [LUPUser]                   VARCHAR (50) NULL,
    [LUPDate]                   DATETIME     NULL,
    [CreateUser]                VARCHAR (50) NULL,
    [CreateDate]                DATETIME     NULL,
    [ExternalTaskingEngineRoot] VARCHAR (50) CONSTRAINT [DF_refTaskCategory_ExternalTaskingEngineRoot] DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_refTaskCategory] PRIMARY KEY CLUSTERED ([pkrefTaskCategory] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkrefTaskCategoryParent]
    ON [dbo].[refTaskCategory]([fkrefTaskCategoryParent] ASC);


GO
CREATE Trigger [dbo].[tr_refTaskCategoryAudit_d] On [dbo].[refTaskCategory]
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
From refTaskCategoryAudit dbTable
Inner Join deleted d ON dbTable.[pkrefTaskCategory] = d.[pkrefTaskCategory]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refTaskCategoryAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefTaskCategory]
	,[fkrefTaskCategoryParent]
	,[CategoryName]
	,[ExternalTaskingEngineRoot]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkrefTaskCategory]
	,[fkrefTaskCategoryParent]
	,[CategoryName]
	,[ExternalTaskingEngineRoot]
From  Deleted
GO
CREATE Trigger [dbo].[tr_refTaskCategoryAudit_UI] On [dbo].[refTaskCategory]
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

Update refTaskCategory
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refTaskCategory dbTable
	Inner Join Inserted i on dbtable.pkrefTaskCategory = i.pkrefTaskCategory
	Left Join Deleted d on d.pkrefTaskCategory = d.pkrefTaskCategory
	Where d.pkrefTaskCategory is null

Update refTaskCategory
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refTaskCategory dbTable
	Inner Join Deleted d on dbTable.pkrefTaskCategory = d.pkrefTaskCategory
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From refTaskCategoryAudit dbTable
Inner Join inserted i ON dbTable.[pkrefTaskCategory] = i.[pkrefTaskCategory]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refTaskCategoryAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefTaskCategory]
	,[fkrefTaskCategoryParent]
	,[CategoryName]
	,[ExternalTaskingEngineRoot]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkrefTaskCategory]
	,[fkrefTaskCategoryParent]
	,[CategoryName]
	,[ExternalTaskingEngineRoot]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This reference table is a reference source for the different categories for tasks within Compass Pilot.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskCategory';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskCategory', @level2type = N'COLUMN', @level2name = N'pkrefTaskCategory';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to find the Task Categoary Parent', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskCategory', @level2type = N'COLUMN', @level2name = N'fkrefTaskCategoryParent';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the task category', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskCategory', @level2type = N'COLUMN', @level2name = N'CategoryName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskCategory', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskCategory', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskCategory', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskCategory', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is the task a part of an external tasking engine, and if so, where should it be categorized.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskCategory', @level2type = N'COLUMN', @level2name = N'ExternalTaskingEngineRoot';

