CREATE TABLE [dbo].[UserTaskTypeDeselectedAudit] (
    [pk]                       DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]           DATETIME     NULL,
    [AuditEndDate]             DATETIME     NULL,
    [AuditUser]                VARCHAR (50) NULL,
    [AuditMachine]             VARCHAR (15) NULL,
    [AuditDeleted]             TINYINT      NULL,
    [pkUserTaskTypeDeselected] DECIMAL (18) NOT NULL,
    [fkApplicationUser]        DECIMAL (18) NOT NULL,
    [fkrefTaskType]            DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_UserTaskTypeDeselectedAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkUserTaskTypeDeselectedAudit]
    ON [dbo].[UserTaskTypeDeselectedAudit]([pkUserTaskTypeDeselected] ASC);

