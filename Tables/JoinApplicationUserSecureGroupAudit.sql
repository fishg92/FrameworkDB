CREATE TABLE [dbo].[JoinApplicationUserSecureGroupAudit] (
    [pk]                               DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                   DATETIME     NULL,
    [AuditEndDate]                     DATETIME     NULL,
    [AuditUser]                        VARCHAR (50) NULL,
    [AuditMachine]                     VARCHAR (15) NULL,
    [AuditDeleted]                     TINYINT      NULL,
    [pkJoinApplicationUserSecureGroup] DECIMAL (18) NOT NULL,
    [fkApplicationUser]                DECIMAL (18) NULL,
    [fkLockedEntity]                   DECIMAL (18) NULL,
    CONSTRAINT [PK_JoinApplicationUserSecureGroupAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinApplicationUserSecureGroupAudit]
    ON [dbo].[JoinApplicationUserSecureGroupAudit]([pkJoinApplicationUserSecureGroup] ASC);

