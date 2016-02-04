CREATE TABLE [dbo].[TaskViewTaskTypeDeselectedAudit] (
    [pk]                           DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]               DATETIME     NULL,
    [AuditEndDate]                 DATETIME     NULL,
    [AuditUser]                    VARCHAR (50) NULL,
    [AuditMachine]                 VARCHAR (15) NULL,
    [AuditDeleted]                 TINYINT      NULL,
    [pkTaskViewTaskTypeDeselected] DECIMAL (18) NOT NULL,
    [fkTaskView]                   DECIMAL (18) NOT NULL,
    [fkrefTaskType]                DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_TaskViewTaskTypeDeselectedAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkTaskViewTaskTypeDeselectedAudit]
    ON [dbo].[TaskViewTaskTypeDeselectedAudit]([pkTaskViewTaskTypeDeselected] ASC);

