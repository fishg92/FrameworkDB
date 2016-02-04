CREATE TABLE [dbo].[refTaskAssignmentStatusAudit] (
    [pk]                             DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                 DATETIME     NULL,
    [AuditEndDate]                   DATETIME     NULL,
    [AuditUser]                      VARCHAR (50) NULL,
    [AuditMachine]                   VARCHAR (15) NULL,
    [AuditDeleted]                   TINYINT      NULL,
    [pkrefTaskAssignmentStatus]      DECIMAL (18) NOT NULL,
    [Description]                    VARCHAR (50) NULL,
    [AssignmentComplete]             BIT          NOT NULL,
    [PropagateTaskStatus]            DECIMAL (18) NOT NULL,
    [fkrefTaskAssignmentStatusGroup] DECIMAL (18) CONSTRAINT [DF_refTaskAssignmentStatusAudit_fkrefTaskAssignmentStatusGroup] DEFAULT ((0)) NOT NULL,
    [Active]                         BIT          CONSTRAINT [DF_refTaskAssignmentStatusAudit_Active] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_refTaskAssignmentStatusAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkrefTaskAssignmentStatusAudit]
    ON [dbo].[refTaskAssignmentStatusAudit]([pkrefTaskAssignmentStatus] ASC);

