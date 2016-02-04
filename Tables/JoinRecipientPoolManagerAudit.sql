CREATE TABLE [dbo].[JoinRecipientPoolManagerAudit] (
    [pk]                         DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]             DATETIME     NULL,
    [AuditEndDate]               DATETIME     NULL,
    [AuditUser]                  VARCHAR (50) NULL,
    [AuditEffectiveUser]         VARCHAR (50) NULL,
    [AuditEffectiveDate]         DATETIME     NULL,
    [AuditMachine]               VARCHAR (15) NULL,
    [AuditDeleted]               TINYINT      NULL,
    [pkJoinRecipientPoolManager] DECIMAL (18) NOT NULL,
    [fkRecipientPool]            DECIMAL (18) NOT NULL,
    [fkApplicationUser]          DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinRecipientPoolManagerAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinRecipientPoolManagerAudit]
    ON [dbo].[JoinRecipientPoolManagerAudit]([pkJoinRecipientPoolManager] ASC);

