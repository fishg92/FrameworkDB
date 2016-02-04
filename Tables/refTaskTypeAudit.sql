CREATE TABLE [dbo].[refTaskTypeAudit] (
    [pk]                       DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]           DATETIME      NULL,
    [AuditEndDate]             DATETIME      NULL,
    [AuditUser]                VARCHAR (50)  NULL,
    [AuditMachine]             VARCHAR (15)  NULL,
    [AuditDeleted]             TINYINT       NULL,
    [pkrefTaskType]            DECIMAL (18)  NOT NULL,
    [Description]              VARCHAR (50)  NULL,
    [DefaultDueMinutes]        DECIMAL (18)  CONSTRAINT [DF__refTaskTy__Defau__65A448B2] DEFAULT ((-1)) NOT NULL,
    [DefaultGroupTask]         BIT           CONSTRAINT [DF__refTaskTy__Defau__66986CEB] DEFAULT ((1)) NOT NULL,
    [DefaultPriority]          TINYINT       CONSTRAINT [DF__refTaskTy__Defau__678C9124] DEFAULT ((2)) NOT NULL,
    [Active]                   BIT           CONSTRAINT [DF__refTaskTy__Activ__6880B55D] DEFAULT ((1)) NOT NULL,
    [fkrefTaskCategory]        DECIMAL (18)  CONSTRAINT [DF__refTaskTy__fkref__6974D996] DEFAULT ((-1)) NOT NULL,
    [DMSTaskTypeID]            VARCHAR (50)  CONSTRAINT [DF__refTaskTy__DMSTa__6A68FDCF] DEFAULT ('') NULL,
    [AllowDelete]              BIT           CONSTRAINT [DF__refTaskTy__Allow__6B5D2208] DEFAULT ((1)) NOT NULL,
    [AllowDescriptionEdit]     BIT           CONSTRAINT [DF__refTaskTy__Allow__6C514641] DEFAULT ((1)) NOT NULL,
    [DMSNewTaskWorkflow]       VARCHAR (50)  CONSTRAINT [DF__refTaskTy__DMSNe__6D456A7A] DEFAULT ('') NULL,
    [AutoComplete]             BIT           CONSTRAINT [DF__refTaskTy__AutoC__6E398EB3] DEFAULT ((0)) NOT NULL,
    [DMSWorkflowName]          VARCHAR (50)  CONSTRAINT [DF__refTaskTy__DMSWo__6F2DB2EC] DEFAULT ('') NULL,
    [DMSRequestedAction]       VARCHAR (100) CONSTRAINT [DF__refTaskTy__DMSRe__720A1F97] DEFAULT ('') NULL,
    [FixedType]                DECIMAL (18)  CONSTRAINT [DF__refTaskTy__Fixed__7021D725] DEFAULT ((0)) NOT NULL,
    [DueDateCalculationMethod] VARCHAR (10)  CONSTRAINT [DF__refTaskTy__DueDa__7115FB5E] DEFAULT ('Calendar') NULL,
    [AuditEffectiveUser]       VARCHAR (50)  NULL,
    [AuditEffectiveDate]       DATETIME      NULL,
    [UseToastNotifications]    BIT           CONSTRAINT [DF__refTaskTy__UseTo__72FE43D0] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_refTaskTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkrefTaskTypeAudit]
    ON [dbo].[refTaskTypeAudit]([pkrefTaskType] ASC);

