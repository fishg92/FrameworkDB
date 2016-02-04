CREATE TABLE [dbo].[RefCredentialTypeAudit] (
    [pk]                  DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]      DATETIME      NULL,
    [AuditEndDate]        DATETIME      NULL,
    [AuditUser]           VARCHAR (50)  NULL,
    [AuditMachine]        VARCHAR (15)  NULL,
    [AuditDeleted]        TINYINT       NULL,
    [pkRefCredentialType] DECIMAL (18)  NOT NULL,
    [Description]         VARCHAR (255) NULL,
    CONSTRAINT [PK_RefCredentialTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkRefCredentialTypeAudit]
    ON [dbo].[RefCredentialTypeAudit]([pkRefCredentialType] ASC);

