CREATE TABLE [dbo].[refTaskEntityType] (
    [pkrefTaskEntityType] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkNCPApplication]    DECIMAL (18) NOT NULL,
    [ParentTable]         VARCHAR (50) CONSTRAINT [DF_refTaskEntityType_ParentTable] DEFAULT ('') NOT NULL,
    [Description]         VARCHAR (50) CONSTRAINT [DF_refTaskEntityType_Description] DEFAULT ('') NOT NULL,
    [EntityJoinTable]     VARCHAR (50) CONSTRAINT [DF_refTaskEntityType_EntityJoinTable] DEFAULT ('') NOT NULL,
    [LUPUser]             VARCHAR (50) NULL,
    [LUPDate]             DATETIME     NULL,
    [CreateUser]          VARCHAR (50) NULL,
    [CreateDate]          DATETIME     NULL,
    CONSTRAINT [PK_refTaskEntityType] PRIMARY KEY CLUSTERED ([pkrefTaskEntityType] ASC),
    CONSTRAINT [Description] UNIQUE NONCLUSTERED ([Description] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkNCPApplication]
    ON [dbo].[refTaskEntityType]([fkNCPApplication] ASC);


GO
CREATE Trigger [dbo].[tr_refTaskEntityTypeAudit_d] On [dbo].[refTaskEntityType]
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
From refTaskEntityTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkrefTaskEntityType] = d.[pkrefTaskEntityType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refTaskEntityTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefTaskEntityType]
	,[fkNCPApplication]
	,[ParentTable]
	,[Description]
	,[EntityJoinTable]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkrefTaskEntityType]
	,[fkNCPApplication]
	,[ParentTable]
	,[Description]
	,[EntityJoinTable]
From  Deleted
GO
CREATE Trigger [dbo].[tr_refTaskEntityTypeAudit_UI] On [dbo].[refTaskEntityType]
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

Update refTaskEntityType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refTaskEntityType dbTable
	Inner Join Inserted i on dbtable.pkrefTaskEntityType = i.pkrefTaskEntityType
	Left Join Deleted d on d.pkrefTaskEntityType = d.pkrefTaskEntityType
	Where d.pkrefTaskEntityType is null

Update refTaskEntityType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refTaskEntityType dbTable
	Inner Join Deleted d on dbTable.pkrefTaskEntityType = d.pkrefTaskEntityType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From refTaskEntityTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkrefTaskEntityType] = i.[pkrefTaskEntityType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refTaskEntityTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefTaskEntityType]
	,[fkNCPApplication]
	,[ParentTable]
	,[Description]
	,[EntityJoinTable]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkrefTaskEntityType]
	,[fkNCPApplication]
	,[ParentTable]
	,[Description]
	,[EntityJoinTable]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table keeps a reference list of the different types of entities that tasks can be linked to, along with information about how to pull that information from the database.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskEntityType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskEntityType', @level2type = N'COLUMN', @level2name = N'pkrefTaskEntityType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to indicate what application the task entity relates to.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskEntityType', @level2type = N'COLUMN', @level2name = N'fkNCPApplication';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What''s the parent table for the task entity type (DMS indicating that the tasks are connected to objects in the DMS)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskEntityType', @level2type = N'COLUMN', @level2name = N'ParentTable';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of what type of entity the task is related to', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskEntityType', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What Join table is used to link these tasks to their objects', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskEntityType', @level2type = N'COLUMN', @level2name = N'EntityJoinTable';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskEntityType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskEntityType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskEntityType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskEntityType', @level2type = N'COLUMN', @level2name = N'CreateDate';

