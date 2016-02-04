CREATE TABLE [dbo].[BarcodeDocumentAudit] (
    [pk]                DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]    DATETIME     NULL,
    [AuditEndDate]      DATETIME     NULL,
    [AuditUser]         VARCHAR (50) NULL,
    [AuditMachine]      VARCHAR (15) NULL,
    [AuditDeleted]      TINYINT      NULL,
    [pkBarcodeDocument] DECIMAL (18) NOT NULL,
    [fkFormName]        DECIMAL (18) NOT NULL,
    [PageCount]         INT          NOT NULL,
    [SendDate]          DATETIME     NOT NULL,
    [fkPSPDocType]      DECIMAL (18) NULL,
    CONSTRAINT [PK_BarcodeDocumentAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkBarcodeDocumentAudit]
    ON [dbo].[BarcodeDocumentAudit]([pkBarcodeDocument] ASC);

