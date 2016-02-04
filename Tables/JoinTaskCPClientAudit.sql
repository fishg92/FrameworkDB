CREATE TABLE [dbo].[JoinTaskCPClientAudit] (
    [pk]                 DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]     DATETIME     NULL,
    [AuditEndDate]       DATETIME     NULL,
    [AuditUser]          VARCHAR (50) NULL,
    [AuditMachine]       VARCHAR (15) NULL,
    [AuditDeleted]       TINYINT      NULL,
    [pkJoinTaskCPClient] DECIMAL (18) NOT NULL,
    [fkCPClient]         DECIMAL (18) NOT NULL,
    [fkTask]             DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinTaskCPClientAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinTaskCPClientAudit]
    ON [dbo].[JoinTaskCPClientAudit]([pkJoinTaskCPClient] ASC);

