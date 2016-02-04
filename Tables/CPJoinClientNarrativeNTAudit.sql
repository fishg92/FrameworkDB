CREATE TABLE [dbo].[CPJoinClientNarrativeNTAudit] (
    [pk]                        DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]            DATETIME     NULL,
    [AuditEndDate]              DATETIME     NULL,
    [AuditUser]                 VARCHAR (50) NULL,
    [AuditMachine]              VARCHAR (15) NULL,
    [AuditDeleted]              TINYINT      NULL,
    [pkCPJoinClientNarrativeNT] DECIMAL (18) NOT NULL,
    [fkCPClient]                DECIMAL (18) NULL,
    [fkCPNarrativeNT]           DECIMAL (18) NULL,
    CONSTRAINT [PK_CPJoinClientNarrativeNTAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPJoinClientNarrativeNTAudit]
    ON [dbo].[CPJoinClientNarrativeNTAudit]([pkCPJoinClientNarrativeNT] ASC);

