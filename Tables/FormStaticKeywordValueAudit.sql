CREATE TABLE [dbo].[FormStaticKeywordValueAudit] (
    [pk]                       DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]           DATETIME      NULL,
    [AuditEndDate]             DATETIME      NULL,
    [AuditUser]                VARCHAR (50)  NULL,
    [AuditMachine]             VARCHAR (15)  NULL,
    [AuditDeleted]             TINYINT       NULL,
    [pkFormStaticKeywordValue] DECIMAL (18)  NOT NULL,
    [StaticKeywordValue]       VARCHAR (100) NULL,
    CONSTRAINT [PK_FormStaticKeywordValueAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormStaticKeywordValueAudit]
    ON [dbo].[FormStaticKeywordValueAudit]([pkFormStaticKeywordValue] ASC);

