CREATE TABLE [dbo].[PSPPrintJobIndexValueAudit] (
    [pk]                      DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]          DATETIME      NULL,
    [AuditEndDate]            DATETIME      NULL,
    [AuditUser]               VARCHAR (50)  NULL,
    [AuditMachine]            VARCHAR (15)  NULL,
    [AuditDeleted]            TINYINT       NULL,
    [pkPSPPrintJobIndexValue] DECIMAL (18)  NOT NULL,
    [fkPSPPrintJob]           DECIMAL (18)  NOT NULL,
    [KeywordName]             VARCHAR (255) NULL,
    [KeywordValue]            VARCHAR (255) NULL,
    CONSTRAINT [PK_PSPPrintJobIndexValueAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkPSPPrintJobIndexValueAudit]
    ON [dbo].[PSPPrintJobIndexValueAudit]([pkPSPPrintJobIndexValue] ASC);

