CREATE TABLE [dbo].[ParserKeyValueAudit] (
    [pk]                     DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]         DATETIME     NULL,
    [AuditEndDate]           DATETIME     NULL,
    [AuditUser]              VARCHAR (50) NULL,
    [AuditMachine]           VARCHAR (15) NULL,
    [AuditDeleted]           TINYINT      NULL,
    [pkParserKeyValue]       DECIMAL (18) NOT NULL,
    [fkParserIdentification] DECIMAL (18) NOT NULL,
    [KeyValueRow]            INT          NOT NULL,
    [KeyValueColumn]         INT          NOT NULL,
    [KeyValueLength]         INT          NOT NULL,
    [KeyValueSearchName]     VARCHAR (50) NULL,
    CONSTRAINT [PK_ParserKeyValueAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkParserKeyValueAudit]
    ON [dbo].[ParserKeyValueAudit]([pkParserKeyValue] ASC);

