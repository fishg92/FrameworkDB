CREATE TABLE [dbo].[BarcodeDocumentPageAudit] (
    [pk]                    DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]        DATETIME      NULL,
    [AuditEndDate]          DATETIME      NULL,
    [AuditUser]             VARCHAR (50)  NULL,
    [AuditMachine]          VARCHAR (15)  NULL,
    [AuditDeleted]          TINYINT       NULL,
    [pkBarcodeDocumentPage] DECIMAL (18)  NOT NULL,
    [fkBarcodeDocument]     DECIMAL (18)  NOT NULL,
    [PageNumber]            INT           NOT NULL,
    [PageScanned]           BIT           NULL,
    [ReturnDate]            SMALLDATETIME NULL,
    CONSTRAINT [PK_BarcodeDocumentPageAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkBarcodeDocumentPageAudit]
    ON [dbo].[BarcodeDocumentPageAudit]([pkBarcodeDocumentPage] ASC);

