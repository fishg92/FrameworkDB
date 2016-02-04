CREATE TABLE [dbo].[refTaskType] (
    [pkrefTaskType]            DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [Description]              VARCHAR (50)  NOT NULL,
    [DefaultDueMinutes]        DECIMAL (18)  CONSTRAINT [DF_refTaskType_DefaultDueMinutes] DEFAULT ((-1)) NOT NULL,
    [DefaultGroupTask]         BIT           CONSTRAINT [DF_refTaskType_DefaultGroupTask] DEFAULT ((1)) NOT NULL,
    [DefaultPriority]          TINYINT       CONSTRAINT [DF_refTaskType_DefaultPriority] DEFAULT ((2)) NOT NULL,
    [Active]                   BIT           CONSTRAINT [DF_refTaskType_Active] DEFAULT ((1)) NOT NULL,
    [fkrefTaskCategory]        DECIMAL (18)  CONSTRAINT [DF_refTaskType_fkrefTaskCategory] DEFAULT ((-1)) NOT NULL,
    [DMSTaskTypeID]            VARCHAR (50)  CONSTRAINT [DF_refTaskType_DMSTaskTypeID] DEFAULT ('') NOT NULL,
    [LUPUser]                  VARCHAR (50)  NULL,
    [LUPDate]                  DATETIME      NULL,
    [CreateUser]               VARCHAR (50)  NULL,
    [CreateDate]               DATETIME      NULL,
    [AllowDelete]              BIT           CONSTRAINT [DF_refTaskType_AllowDelete] DEFAULT ((1)) NOT NULL,
    [AllowDescriptionEdit]     BIT           CONSTRAINT [DF_refTaskType_AllowDescriptionEdit] DEFAULT ((1)) NOT NULL,
    [DMSNewTaskWorkflow]       VARCHAR (50)  CONSTRAINT [DF_refTaskType_DMSNewTaskQueue] DEFAULT ('') NOT NULL,
    [AutoComplete]             BIT           CONSTRAINT [DF_refTaskType_AutoComplete] DEFAULT ((0)) NOT NULL,
    [DMSWorkflowName]          VARCHAR (50)  CONSTRAINT [DF_refTaskType_DMSWorkflowName] DEFAULT ('') NOT NULL,
    [DMSRequestedAction]       VARCHAR (100) CONSTRAINT [DF_refTaskType_DMSRequestedAction] DEFAULT ('') NOT NULL,
    [FixedType]                DECIMAL (18)  CONSTRAINT [DF_refTaskType_FixedType] DEFAULT ((0)) NOT NULL,
    [DueDateCalculationMethod] VARCHAR (10)  CONSTRAINT [DF_refTaskType_DueDateCalculationMethod] DEFAULT ('Calendar') NOT NULL,
    [UseToastNotifications]    BIT           CONSTRAINT [DF_refTaskType_UseToastNotifications] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_refTaskType] PRIMARY KEY CLUSTERED ([pkrefTaskType] ASC),
    CONSTRAINT [CK_refTaskType] CHECK ([DueDateCalculationMethod]='Business' OR [DueDateCalculationMethod]='Calendar'),
    CONSTRAINT [CK_refTaskTypePriority] CHECK ([DefaultPriority]=(3) OR [DefaultPriority]=(2) OR [DefaultPriority]=(1)),
    CONSTRAINT [refTaskType_Description] UNIQUE NONCLUSTERED ([Description] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkrefTaskCategory]
    ON [dbo].[refTaskType]([fkrefTaskCategory] ASC);


GO
CREATE Trigger [dbo].[tr_refTaskTypeAudit_UI] On [dbo].[refTaskType]
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

Update refTaskType
	 Set [CreateUser] = @AuditUser
,[CreateDate] = @Date
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From refTaskType dbTable
	Inner Join Inserted i on dbtable.pkrefTaskType = i.pkrefTaskType
	Left Join Deleted d on d.pkrefTaskType = d.pkrefTaskType
	Where d.pkrefTaskType is null

Update refTaskType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From refTaskType dbTable
	Inner Join Deleted d on dbTable.pkrefTaskType = d.pkrefTaskType

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From refTaskTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkrefTaskType] = i.[pkrefTaskType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refTaskTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefTaskType]
	,[Description]
	,[DefaultDueMinutes]
	,[DefaultGroupTask]
	,[DefaultPriority]
	,[Active]
	,[fkrefTaskCategory]
	,[DMSTaskTypeID]
	,[AllowDelete]
	,[AllowDescriptionEdit]
	,[DMSNewTaskWorkflow]
	,[AutoComplete]
	,[DMSWorkflowName]
	,[FixedType]
	,[DueDateCalculationMethod]
	,[DMSRequestedAction]
	,[UseToastNotifications]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkrefTaskType]
	,[Description]
	,[DefaultDueMinutes]
	,[DefaultGroupTask]
	,[DefaultPriority]
	,[Active]
	,[fkrefTaskCategory]
	,[DMSTaskTypeID]
	,[AllowDelete]
	,[AllowDescriptionEdit]
	,[DMSNewTaskWorkflow]
	,[AutoComplete]
	,[DMSWorkflowName]
	,[FixedType]
	,[DueDateCalculationMethod]
	,[DMSRequestedAction]
	,[UseToastNotifications]

From  Inserted
GO
CREATE Trigger [dbo].[tr_refTaskTypeAudit_d] On [dbo].[refTaskType]
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
From refTaskTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkrefTaskType] = d.[pkrefTaskType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refTaskTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefTaskType]
	,[Description]
	,[DefaultDueMinutes]
	,[DefaultGroupTask]
	,[DefaultPriority]
	,[Active]
	,[fkrefTaskCategory]
	,[DMSTaskTypeID]
	,[AllowDelete]
	,[AllowDescriptionEdit]
	,[DMSNewTaskWorkflow]
	,[AutoComplete]
	,[DMSWorkflowName]
	,[FixedType]
	,[DueDateCalculationMethod]
	,[DMSRequestedAction]
	,[UseToastNotifications]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkrefTaskType]
	,[Description]
	,[DefaultDueMinutes]
	,[DefaultGroupTask]
	,[DefaultPriority]
	,[Active]
	,[fkrefTaskCategory]
	,[DMSTaskTypeID]
	,[AllowDelete]
	,[AllowDescriptionEdit]
	,[DMSNewTaskWorkflow]
	,[AutoComplete]
	,[DMSWorkflowName]
	,[FixedType]
	,[DueDateCalculationMethod]
	,[DMSRequestedAction]
	,[UseToastNotifications]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ensure default priority is within acceptable range', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'CONSTRAINT', @level2name = N'CK_refTaskTypePriority';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This reference table stores information about the different types of tasks in Pilot and how they relate to the DMS task workflow engine where appropriate.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'pkrefTaskType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of what sort of task this might be (for example, a "Client Follow Up Call" or "New Scanned Document")', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Tasks of this type are due in how many minutes (for reference, there are 1440 minutes in a day)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'DefaultDueMinutes';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Are tasks of this type generally considered to by group tasks', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'DefaultGroupTask';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'How should tasks of this type usually be prioritiezed?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'DefaultPriority';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is this task type still in use (1=yes)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'Active';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Reference to task category', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'fkrefTaskCategory';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'In the DMS, tasks of this type are identified by what key number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'DMSTaskTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Are tasks of this type allowed to be deleted (1=yes)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'AllowDelete';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Are users allowed to edit the description of tasks with this type (1=yes)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'AllowDescriptionEdit';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The workflow that a task should be added to in the DMS (DMS key for the workflow)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'DMSNewTaskWorkflow';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is the task meant to be automatically marked complete?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'AutoComplete';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of the workflow in the DMS to add the task to', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'DMSWorkflowName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Action that the DMS should take for this task', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'DMSRequestedAction';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'FixedType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Calculate by calendar or business days', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'DueDateCalculationMethod';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Flag determining whether task type uses Toast or Balloon Notification Style', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTaskType', @level2type = N'COLUMN', @level2name = N'UseToastNotifications';

