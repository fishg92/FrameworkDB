CREATE TABLE [dbo].[ParserIdentificationAudit] (
    [pk]                     DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]         DATETIME     NULL,
    [AuditEndDate]           DATETIME     NULL,
    [AuditUser]              VARCHAR (50) NULL,
    [AuditMachine]           VARCHAR (15) NULL,
    [AuditDeleted]           TINYINT      NULL,
    [pkParserIdentification] DECIMAL (18) NOT NULL,
    [IdentificationString]   VARCHAR (80) NULL,
    [IdentificationRow]      INT          NOT NULL,
    [IdentificationColumn]   INT          NOT NULL,
    CONSTRAINT [PK_ParserIdentificationAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkParserIdentificationAudit]
    ON [dbo].[ParserIdentificationAudit]([pkParserIdentification] ASC);

