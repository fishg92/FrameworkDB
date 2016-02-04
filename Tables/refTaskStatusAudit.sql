CREATE TABLE [dbo].[refTaskStatusAudit] (
    [pk]              DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]  DATETIME     NULL,
    [AuditEndDate]    DATETIME     NULL,
    [AuditUser]       VARCHAR (50) NULL,
    [AuditMachine]    VARCHAR (15) NULL,
    [AuditDeleted]    TINYINT      NULL,
    [pkrefTaskStatus] DECIMAL (18) NOT NULL,
    [Description]     VARCHAR (50) NULL,
    [TaskComplete]    BIT          NOT NULL,
    CONSTRAINT [PK_refTaskStatusAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkrefTaskStatusAudit]
    ON [dbo].[refTaskStatusAudit]([pkrefTaskStatus] ASC);

