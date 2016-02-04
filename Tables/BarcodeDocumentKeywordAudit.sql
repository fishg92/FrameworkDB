CREATE TABLE [dbo].[BarcodeDocumentKeywordAudit] (
    [pk]                       DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]           DATETIME      NULL,
    [AuditEndDate]             DATETIME      NULL,
    [AuditUser]                VARCHAR (50)  NULL,
    [AuditMachine]             VARCHAR (15)  NULL,
    [AuditDeleted]             TINYINT       NULL,
    [pkBarcodeDocumentKeyword] DECIMAL (18)  NOT NULL,
    [fkBarcodeDocument]        DECIMAL (18)  NOT NULL,
    [KeywordGroup]             INT           NOT NULL,
    [KeywordName]              VARCHAR (50)  NULL,
    [KeywordValue]             VARCHAR (255) NULL,
    [KeywordID]                VARCHAR (50)  NULL,
    CONSTRAINT [PK_BarcodeDocumentKeywordAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkBarcodeDocumentKeywordAudit]
    ON [dbo].[BarcodeDocumentKeywordAudit]([pkBarcodeDocumentKeyword] ASC);

