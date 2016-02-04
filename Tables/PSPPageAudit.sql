CREATE TABLE [dbo].[PSPPageAudit] (
    [pk]             DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME     NULL,
    [AuditEndDate]   DATETIME     NULL,
    [AuditUser]      VARCHAR (50) NULL,
    [AuditMachine]   VARCHAR (15) NULL,
    [AuditDeleted]   TINYINT      NULL,
    [pkPSPPage]      DECIMAL (18) NOT NULL,
    [fkPSPDocType]   DECIMAL (18) NOT NULL,
    [PageNumber]     INT          NOT NULL,
    CONSTRAINT [PK_PSPPageAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkPSPPageAudit]
    ON [dbo].[PSPPageAudit]([pkPSPPage] ASC);

