CREATE TABLE [dbo].[CPJoinClientCaseNarrativeNTAudit] (
    [pk]                            DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                DATETIME     NULL,
    [AuditEndDate]                  DATETIME     NULL,
    [AuditUser]                     VARCHAR (50) NULL,
    [AuditMachine]                  VARCHAR (15) NULL,
    [AuditDeleted]                  TINYINT      NULL,
    [pkCPJoinClientCaseNarrativeNT] DECIMAL (18) NOT NULL,
    [fkCPClientCase]                DECIMAL (18) NULL,
    [fkCPNarrativeNT]               DECIMAL (18) NULL,
    CONSTRAINT [PK_CPJoinClientCaseNarrativeNTAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPJoinClientCaseNarrativeNTAudit]
    ON [dbo].[CPJoinClientCaseNarrativeNTAudit]([pkCPJoinClientCaseNarrativeNT] ASC);

