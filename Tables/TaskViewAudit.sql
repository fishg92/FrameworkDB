CREATE TABLE [dbo].[TaskViewAudit] (
    [pk]                DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]    DATETIME      NULL,
    [AuditEndDate]      DATETIME      NULL,
    [AuditUser]         VARCHAR (50)  NULL,
    [AuditMachine]      VARCHAR (15)  NULL,
    [AuditDeleted]      TINYINT       NULL,
    [pkTaskView]        DECIMAL (18)  NOT NULL,
    [fkApplicationUser] DECIMAL (18)  CONSTRAINT [DF_TaskViewAudit_fkApplicationUser] DEFAULT ((-1)) NOT NULL,
    [ViewName]          VARCHAR (100) CONSTRAINT [DF_TaskViewAudit_ViewName] DEFAULT ('') NOT NULL,
    [IsGlobal]          BIT           CONSTRAINT [DF_TaskViewAudit_IsGlobal] DEFAULT ((0)) NOT NULL,
    [ShowUnread]        BIT           CONSTRAINT [DF_TaskViewAudit_ShowUnread] DEFAULT ((0)) NOT NULL,
    [IgnoreFilters]     BIT           CONSTRAINT [DF_TaskViewAudit_IgnoreFilters] DEFAULT ((0)) NOT NULL,
    [IncludeCompleted]  BIT           CONSTRAINT [DF_TaskViewAudit_IncludeCompleted] DEFAULT ((0)) NOT NULL,
    [CompletedDate]     DATETIME      NULL,
    [FromNumDaysSpan]   INT           CONSTRAINT [DF_TaskViewAudit_FromNumDaysSpan] DEFAULT ((0)) NOT NULL,
    [ColumnSettings]    VARCHAR (MAX) CONSTRAINT [DF_TaskViewAudit_ColumnSettings] DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_TaskViewAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkTaskViewAudit]
    ON [dbo].[TaskViewAudit]([pkTaskView] ASC);

