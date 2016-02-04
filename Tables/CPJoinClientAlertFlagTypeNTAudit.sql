CREATE TABLE [dbo].[CPJoinClientAlertFlagTypeNTAudit] (
    [pk]                            DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                DATETIME     NULL,
    [AuditEndDate]                  DATETIME     NULL,
    [AuditUser]                     VARCHAR (50) NULL,
    [AuditMachine]                  VARCHAR (15) NULL,
    [AuditDeleted]                  TINYINT      NULL,
    [pkCPJoinClientAlertFlagTypeNT] DECIMAL (18) NOT NULL,
    [fkCPClient]                    DECIMAL (18) NULL,
    [fkRefCPAlertFlagTypeNT]        DECIMAL (18) NULL,
    [LockedUser]                    VARCHAR (20) NULL,
    [LockedDate]                    DATETIME     NULL,
    CONSTRAINT [PK_CPJoinClientAlertFlagTypeNTAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPJoinClientAlertFlagTypeNTAudit]
    ON [dbo].[CPJoinClientAlertFlagTypeNTAudit]([pkCPJoinClientAlertFlagTypeNT] ASC);

