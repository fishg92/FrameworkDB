CREATE TABLE [dbo].[FormPathAudit] (
    [pk]             DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME      NULL,
    [AuditEndDate]   DATETIME      NULL,
    [AuditUser]      VARCHAR (50)  NULL,
    [AuditMachine]   VARCHAR (15)  NULL,
    [AuditDeleted]   TINYINT       NULL,
    [pkFormPath]     DECIMAL (18)  NOT NULL,
    [fkFormName]     DECIMAL (18)  NOT NULL,
    [Path]           VARCHAR (500) NULL,
    CONSTRAINT [PK_FormPathAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormPathAudit]
    ON [dbo].[FormPathAudit]([pkFormPath] ASC);

