CREATE TABLE [dbo].[FormQuickListFolderAudit] (
    [pk]                        DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]            DATETIME     NULL,
    [AuditEndDate]              DATETIME     NULL,
    [AuditUser]                 VARCHAR (50) NULL,
    [AuditMachine]              VARCHAR (15) NULL,
    [AuditDeleted]              TINYINT      NULL,
    [pkFormQuickListFolder]     DECIMAL (18) NOT NULL,
    [fkFormQuickListFolder]     DECIMAL (18) NOT NULL,
    [fkFormUser]                DECIMAL (18) NOT NULL,
    [fkFormQuickListFolderName] DECIMAL (18) NOT NULL,
    [DeleteOnFinish]            BIT          NULL,
    CONSTRAINT [PK_FormQuickListFolderAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormQuickListFolderAudit]
    ON [dbo].[FormQuickListFolderAudit]([pkFormQuickListFolder] ASC);

