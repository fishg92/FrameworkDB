CREATE TABLE [dbo].[ProfileStaticKeywordsAudit] (
    [pk]                      DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]          DATETIME      NULL,
    [AuditEndDate]            DATETIME      NULL,
    [AuditUser]               VARCHAR (50)  NULL,
    [AuditEffectiveUser]      VARCHAR (50)  NULL,
    [AuditEffectiveDate]      DATETIME      NULL,
    [AuditMachine]            VARCHAR (15)  NULL,
    [AuditDeleted]            TINYINT       NULL,
    [pkProfileStaticKeywords] DECIMAL (18)  NOT NULL,
    [fkProfile]               DECIMAL (18)  NOT NULL,
    [fkKeywordType]           VARCHAR (50)  NULL,
    [KeywordValue]            VARCHAR (100) NULL,
    CONSTRAINT [PK_ProfileStaticKeywordsAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkProfileStaticKeywordsAudit]
    ON [dbo].[ProfileStaticKeywordsAudit]([pkProfileStaticKeywords] ASC);

