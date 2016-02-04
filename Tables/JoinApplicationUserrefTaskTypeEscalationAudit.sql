CREATE TABLE [dbo].[JoinApplicationUserrefTaskTypeEscalationAudit] (
    [pk]                                         DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                             DATETIME     NULL,
    [AuditEndDate]                               DATETIME     NULL,
    [AuditUser]                                  VARCHAR (50) NULL,
    [AuditMachine]                               VARCHAR (15) NULL,
    [AuditDeleted]                               TINYINT      NULL,
    [pkJoinApplicationUserrefTaskTypeEscalation] DECIMAL (18) NOT NULL,
    [fkrefTaskTypeEscalation]                    DECIMAL (18) NOT NULL,
    [fkApplicationUser]                          DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinApplicationUserrefTaskTypeEscalationAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinApplicationUserrefTaskTypeEscalationAudit]
    ON [dbo].[JoinApplicationUserrefTaskTypeEscalationAudit]([pkJoinApplicationUserrefTaskTypeEscalation] ASC);

