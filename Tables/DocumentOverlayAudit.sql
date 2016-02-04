CREATE TABLE [dbo].[DocumentOverlayAudit] (
    [pk]                DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]    DATETIME     NULL,
    [AuditEndDate]      DATETIME     NULL,
    [AuditUser]         VARCHAR (50) NULL,
    [AuditMachine]      VARCHAR (15) NULL,
    [AuditDeleted]      TINYINT      NULL,
    [pkDocumentOverlay] DECIMAL (18) NOT NULL,
    [Description]       VARCHAR (50) NULL,
    [OverlayImage]      IMAGE        NULL,
    CONSTRAINT [PK_DocumentOverlayAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkDocumentOverlayAudit]
    ON [dbo].[DocumentOverlayAudit]([pkDocumentOverlay] ASC);

