CREATE TABLE [dbo].[PSPPrinterNameAudit] (
    [pk]               DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]   DATETIME      NULL,
    [AuditEndDate]     DATETIME      NULL,
    [AuditUser]        VARCHAR (50)  NULL,
    [AuditMachine]     VARCHAR (15)  NULL,
    [AuditDeleted]     TINYINT       NULL,
    [pkPSPPrinterName] DECIMAL (18)  NOT NULL,
    [PrinterName]      VARCHAR (255) NULL,
    CONSTRAINT [PK_PSPPrinterNameAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkPSPPrinterNameAudit]
    ON [dbo].[PSPPrinterNameAudit]([pkPSPPrinterName] ASC);

