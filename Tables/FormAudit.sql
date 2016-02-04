CREATE TABLE [dbo].[FormAudit] (
    [pk]             DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME      NULL,
    [AuditEndDate]   DATETIME      NULL,
    [AuditUser]      VARCHAR (50)  NULL,
    [AuditMachine]   VARCHAR (15)  NULL,
    [AuditDeleted]   TINYINT       NULL,
    [pkForm]         DECIMAL (18)  NOT NULL,
    [FormName]       VARCHAR (500) NULL,
    CONSTRAINT [PK_FormAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormAudit]
    ON [dbo].[FormAudit]([pkForm] ASC);

