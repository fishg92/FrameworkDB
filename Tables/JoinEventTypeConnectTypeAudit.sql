CREATE TABLE [dbo].[JoinEventTypeConnectTypeAudit] (
    [pk]                         DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]             DATETIME     NULL,
    [AuditEndDate]               DATETIME     NULL,
    [AuditUser]                  VARCHAR (50) NULL,
    [AuditMachine]               VARCHAR (15) NULL,
    [AuditDeleted]               TINYINT      NULL,
    [pkJoinEventTypeConnectType] DECIMAL (18) NOT NULL,
    [fkEventType]                DECIMAL (18) NULL,
    [fkConnectType]              DECIMAL (18) NULL,
    CONSTRAINT [PK_JoinEventTypeConnectTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinEventTypeConnectTypeAudit]
    ON [dbo].[JoinEventTypeConnectTypeAudit]([pkJoinEventTypeConnectType] ASC);

