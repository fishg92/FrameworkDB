CREATE TABLE [dbo].[JoinTaskDocumentAudit] (
    [pk]                 DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]     DATETIME     NULL,
    [AuditEndDate]       DATETIME     NULL,
    [AuditUser]          VARCHAR (50) NULL,
    [AuditMachine]       VARCHAR (15) NULL,
    [AuditDeleted]       TINYINT      NULL,
    [pkJoinTaskDocument] DECIMAL (18) NOT NULL,
    [fkDocument]         VARCHAR (50) NULL,
    [fkTask]             DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinTaskDocumentAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinTaskDocumentAudit]
    ON [dbo].[JoinTaskDocumentAudit]([pkJoinTaskDocument] ASC);

