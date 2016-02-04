CREATE TABLE [dbo].[FormFolderAudit] (
    [pk]               DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]   DATETIME     NULL,
    [AuditEndDate]     DATETIME     NULL,
    [AuditUser]        VARCHAR (50) NULL,
    [AuditMachine]     VARCHAR (15) NULL,
    [AuditDeleted]     TINYINT      NULL,
    [pkFormFolder]     DECIMAL (18) NOT NULL,
    [fkFormFolder]     DECIMAL (18) NOT NULL,
    [fkFormFolderName] DECIMAL (18) NOT NULL,
    [Hidden]           INT          NULL,
    CONSTRAINT [PK_FormFolderAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormFolderAudit]
    ON [dbo].[FormFolderAudit]([pkFormFolder] ASC);

