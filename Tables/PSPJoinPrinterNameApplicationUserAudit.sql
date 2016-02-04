CREATE TABLE [dbo].[PSPJoinPrinterNameApplicationUserAudit] (
    [pk]                                  DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                      DATETIME     NULL,
    [AuditEndDate]                        DATETIME     NULL,
    [AuditUser]                           VARCHAR (50) NULL,
    [AuditMachine]                        VARCHAR (15) NULL,
    [AuditDeleted]                        TINYINT      NULL,
    [pkPSPJoinPrinterNameApplicationUser] DECIMAL (18) NOT NULL,
    [fkPSPPrinterName]                    DECIMAL (18) NOT NULL,
    [fkApplicationUser]                   DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_PSPJoinPrinterNameApplicationUserAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkPSPJoinPrinterNameApplicationUserAudit]
    ON [dbo].[PSPJoinPrinterNameApplicationUserAudit]([pkPSPJoinPrinterNameApplicationUser] ASC);

