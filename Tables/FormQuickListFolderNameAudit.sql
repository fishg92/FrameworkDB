CREATE TABLE [dbo].[FormQuickListFolderNameAudit] (
    [pk]                        DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]            DATETIME      NULL,
    [AuditEndDate]              DATETIME      NULL,
    [AuditUser]                 VARCHAR (50)  NULL,
    [AuditMachine]              VARCHAR (15)  NULL,
    [AuditDeleted]              TINYINT       NULL,
    [pkFormQuickListFolderName] DECIMAL (18)  NOT NULL,
    [QuickListFolderName]       VARCHAR (255) NULL,
    [Description]               VARCHAR (500) NULL,
    CONSTRAINT [PK_FormQuickListFolderNameAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormQuickListFolderNameAudit]
    ON [dbo].[FormQuickListFolderNameAudit]([pkFormQuickListFolderName] ASC);

