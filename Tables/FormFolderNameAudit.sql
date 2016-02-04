CREATE TABLE [dbo].[FormFolderNameAudit] (
    [pk]               DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]   DATETIME      NULL,
    [AuditEndDate]     DATETIME      NULL,
    [AuditUser]        VARCHAR (50)  NULL,
    [AuditMachine]     VARCHAR (15)  NULL,
    [AuditDeleted]     TINYINT       NULL,
    [pkFormFolderName] DECIMAL (18)  NOT NULL,
    [FolderName]       VARCHAR (255) NULL,
    [Description]      VARCHAR (500) NULL,
    CONSTRAINT [PK_FormFolderNameAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormFolderNameAudit]
    ON [dbo].[FormFolderNameAudit]([pkFormFolderName] ASC);

