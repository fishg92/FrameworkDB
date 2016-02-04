CREATE TABLE [dbo].[JoinTaskCPClientCaseAudit] (
    [pk]                     DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]         DATETIME     NULL,
    [AuditEndDate]           DATETIME     NULL,
    [AuditUser]              VARCHAR (50) NULL,
    [AuditMachine]           VARCHAR (15) NULL,
    [AuditDeleted]           TINYINT      NULL,
    [pkJoinTaskCPClientCase] DECIMAL (18) NOT NULL,
    [fkCPClientCase]         DECIMAL (18) NOT NULL,
    [fkTask]                 DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinTaskCPClientCaseAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinTaskCPClientCaseAudit]
    ON [dbo].[JoinTaskCPClientCaseAudit]([pkJoinTaskCPClientCase] ASC);

