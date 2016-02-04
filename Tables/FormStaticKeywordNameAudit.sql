CREATE TABLE [dbo].[FormStaticKeywordNameAudit] (
    [pk]                      DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]          DATETIME     NULL,
    [AuditEndDate]            DATETIME     NULL,
    [AuditUser]               VARCHAR (50) NULL,
    [AuditMachine]            VARCHAR (15) NULL,
    [AuditDeleted]            TINYINT      NULL,
    [pkFormStaticKeywordName] DECIMAL (18) NOT NULL,
    [fkKeywordType]           VARCHAR (50) NULL,
    CONSTRAINT [PK_FormStaticKeywordNameAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormStaticKeywordNameAudit]
    ON [dbo].[FormStaticKeywordNameAudit]([pkFormStaticKeywordName] ASC);

