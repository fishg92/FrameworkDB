CREATE TABLE [dbo].[LanguageAudit] (
    [pk]             DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME       NULL,
    [AuditEndDate]   DATETIME       NULL,
    [AuditUser]      VARCHAR (50)   NULL,
    [AuditMachine]   VARCHAR (15)   NULL,
    [AuditDeleted]   TINYINT        NULL,
    [pkLanguage]     DECIMAL (18)   NOT NULL,
    [Description]    VARCHAR (50)   NULL,
    [Active]         BIT            NOT NULL,
    [DisplayText]    NVARCHAR (100) NULL,
    CONSTRAINT [PK_LanguageAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkLanguageAudit]
    ON [dbo].[LanguageAudit]([pkLanguage] ASC);

