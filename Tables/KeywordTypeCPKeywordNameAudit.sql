CREATE TABLE [dbo].[KeywordTypeCPKeywordNameAudit] (
    [pk]                         DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]             DATETIME     NULL,
    [AuditEndDate]               DATETIME     NULL,
    [AuditUser]                  VARCHAR (50) NULL,
    [AuditMachine]               VARCHAR (15) NULL,
    [AuditDeleted]               TINYINT      NULL,
    [pkKeywordTypeCPKeywordName] DECIMAL (18) NOT NULL,
    [fkKeywordType]              VARCHAR (50) NULL,
    [CPKeywordName]              VARCHAR (50) NULL,
    CONSTRAINT [PK_KeywordTypeCPKeywordNameAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkKeywordTypeCPKeywordNameAudit]
    ON [dbo].[KeywordTypeCPKeywordNameAudit]([pkKeywordTypeCPKeywordName] ASC);

