CREATE TABLE [dbo].[FormJoinQuickListFormFolderQuickListFormNameAudit] (
    [pk]                                             DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                                 DATETIME     NULL,
    [AuditEndDate]                                   DATETIME     NULL,
    [AuditUser]                                      VARCHAR (50) NULL,
    [AuditMachine]                                   VARCHAR (15) NULL,
    [AuditDeleted]                                   TINYINT      NULL,
    [pkFormJoinQuickListFormFolderQuickListFormName] DECIMAL (18) NOT NULL,
    [fkFormQuickListFolder]                          DECIMAL (18) NOT NULL,
    [fkFormQuickListFormName]                        DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_FormJoinQuickListFormFolderQuickListFormNameAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormJoinQuickListFormFolderQuickListFormNameAudit]
    ON [dbo].[FormJoinQuickListFormFolderQuickListFormNameAudit]([pkFormJoinQuickListFormFolderQuickListFormName] ASC);

