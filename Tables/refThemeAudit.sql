CREATE TABLE [dbo].[refThemeAudit] (
    [pk]             DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME     NULL,
    [AuditEndDate]   DATETIME     NULL,
    [AuditUser]      VARCHAR (50) NULL,
    [AuditMachine]   VARCHAR (15) NULL,
    [AuditDeleted]   TINYINT      NULL,
    [pkrefTheme]     DECIMAL (18) NOT NULL,
    [KeyName]        VARCHAR (50) NULL,
    [Description]    VARCHAR (50) NULL,
    CONSTRAINT [PK_refThemeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkrefThemeAudit]
    ON [dbo].[refThemeAudit]([pkrefTheme] ASC);

