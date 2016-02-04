CREATE TABLE [dbo].[JoinTaskCPClientFormNameAudit] (
    [pk]                         DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]             DATETIME     NULL,
    [AuditEndDate]               DATETIME     NULL,
    [AuditUser]                  VARCHAR (50) NULL,
    [AuditMachine]               VARCHAR (15) NULL,
    [AuditDeleted]               TINYINT      NULL,
    [pkJoinTaskCPClientFormName] DECIMAL (18) NOT NULL,
    [fkJoinTaskCPClient]         DECIMAL (18) NOT NULL,
    [fkFormName]                 DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinTaskCPClientFormNameAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinTaskCPClientFormNameAudit]
    ON [dbo].[JoinTaskCPClientFormNameAudit]([pkJoinTaskCPClientFormName] ASC);

