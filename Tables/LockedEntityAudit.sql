CREATE TABLE [dbo].[LockedEntityAudit] (
    [pk]             DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME     NULL,
    [AuditEndDate]   DATETIME     NULL,
    [AuditUser]      VARCHAR (50) NULL,
    [AuditMachine]   VARCHAR (15) NULL,
    [AuditDeleted]   TINYINT      NULL,
    [pkLockedEntity] DECIMAL (18) NOT NULL,
    [fkCPClient]     DECIMAL (18) NULL,
    [fkrefRole]      DECIMAL (18) NULL,
    [fkProgramType]  DECIMAL (18) NULL,
    CONSTRAINT [PK_LockedEntityAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkLockedEntityAudit]
    ON [dbo].[LockedEntityAudit]([pkLockedEntity] ASC);

