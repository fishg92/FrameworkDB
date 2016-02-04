CREATE TABLE [dbo].[refPermission] (
    [pkrefPermission]            DECIMAL (18)   NOT NULL,
    [Description]                VARCHAR (100)  NOT NULL,
    [EnumDescriptor]             VARCHAR (100)  NULL,
    [fkApplication]              DECIMAL (18)   NULL,
    [TreeGroup]                  VARCHAR (100)  NULL,
    [TreeSubGroup]               VARCHAR (100)  NULL,
    [TreeNode]                   VARCHAR (100)  NULL,
    [ParentRestriction]          DECIMAL (18)   NULL,
    [TreeNodeSeq]                INT            NULL,
    [DetailedDescription]        VARCHAR (2000) NULL,
    [LUPUser]                    VARCHAR (50)   NULL,
    [LUPDate]                    DATETIME       NULL,
    [CreateUser]                 VARCHAR (50)   NULL,
    [CreateDate]                 DATETIME       NULL,
    [RequiredForThisApplication] TINYINT        NULL,
    [RequiredForGlobalOptions]   TINYINT        CONSTRAINT [DF_refPermission_RequiredForGlobalOptions] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_refPermission] PRIMARY KEY CLUSTERED ([pkrefPermission] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplication]
    ON [dbo].[refPermission]([fkApplication] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_refPermissionAudit_UI] On [dbo].[refPermission]
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

Update refPermission
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refPermission dbTable
	Inner Join Inserted i on dbtable.pkrefPermission = i.pkrefPermission
	Left Join Deleted d on d.pkrefPermission = d.pkrefPermission
	Where d.pkrefPermission is null

Update refPermission
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refPermission dbTable
	Inner Join Deleted d on dbTable.pkrefPermission = d.pkrefPermission
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From refPermissionAudit dbTable
Inner Join inserted i ON dbTable.[pkrefPermission] = i.[pkrefPermission]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refPermissionAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefPermission]
	,[Description]
	,[EnumDescriptor]
	,[fkApplication]
	,[TreeGroup]
	,[TreeSubGroup]
	,[TreeNode]
	,[ParentRestriction]
	,[TreeNodeSeq]
	,[DetailedDescription]
	,[RequiredForThisApplication]
	,[RequiredForGlobalOptions]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkrefPermission]
	,[Description]
	,[EnumDescriptor]
	,[fkApplication]
	,[TreeGroup]
	,[TreeSubGroup]
	,[TreeNode]
	,[ParentRestriction]
	,[TreeNodeSeq]
	,[DetailedDescription]
	,[RequiredForThisApplication]
	,[RequiredForGlobalOptions]

From  Inserted
GO
CREATE Trigger [dbo].[tr_refPermissionAudit_d] On [dbo].[refPermission]
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
From refPermissionAudit dbTable
Inner Join deleted d ON dbTable.[pkrefPermission] = d.[pkrefPermission]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refPermissionAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefPermission]
	,[Description]
	,[EnumDescriptor]
	,[fkApplication]
	,[TreeGroup]
	,[TreeSubGroup]
	,[TreeNode]
	,[ParentRestriction]
	,[TreeNodeSeq]
	,[DetailedDescription]
	,[RequiredForThisApplication]
	,[RequiredForGlobalOptions]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkrefPermission]
	,[Description]
	,[EnumDescriptor]
	,[fkApplication]
	,[TreeGroup]
	,[TreeSubGroup]
	,[TreeNode]
	,[ParentRestriction]
	,[TreeNodeSeq]
	,[DetailedDescription]
	,[RequiredForThisApplication]
	,[RequiredForGlobalOptions]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ref tables are reference tables that are used to populate drop downs, enumerate options, or otherwise provide a (usually) static list of items to the program. This table is used as a reference location for the various permissions that are configuarable for a Compass user.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refPermission';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refPermission', @level2type = N'COLUMN', @level2name = N'pkrefPermission';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the permission', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refPermission', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Corresponding text for the enumeration of permissions in code', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refPermission', @level2type = N'COLUMN', @level2name = N'EnumDescriptor';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the Application list', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refPermission', @level2type = N'COLUMN', @level2name = N'fkApplication';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Under what branch of the tree is this permission kept', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refPermission', @level2type = N'COLUMN', @level2name = N'TreeGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What sub branch of the main branch should contain this permission?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refPermission', @level2type = N'COLUMN', @level2name = N'TreeSubGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Display name for the node of the tree that represents this permissions', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refPermission', @level2type = N'COLUMN', @level2name = N'TreeNode';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What permission must be granted for this permission to be granted', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refPermission', @level2type = N'COLUMN', @level2name = N'ParentRestriction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ordering of the tree node within the group', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refPermission', @level2type = N'COLUMN', @level2name = N'TreeNodeSeq';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'An optional field to put in detailed descriptions and notes about the permission.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refPermission', @level2type = N'COLUMN', @level2name = N'DetailedDescription';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refPermission', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refPermission', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refPermission', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refPermission', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is this permissions required to run the associated application', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refPermission', @level2type = N'COLUMN', @level2name = N'RequiredForThisApplication';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is this permission required in order to change global options in Compass Pilot', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refPermission', @level2type = N'COLUMN', @level2name = N'RequiredForGlobalOptions';

