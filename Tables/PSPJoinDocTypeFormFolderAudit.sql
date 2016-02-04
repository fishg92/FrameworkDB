CREATE TABLE [dbo].[PSPJoinDocTypeFormFolderAudit] (
    [pk]                         DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]             DATETIME     NULL,
    [AuditEndDate]               DATETIME     NULL,
    [AuditUser]                  VARCHAR (50) NULL,
    [AuditMachine]               VARCHAR (15) NULL,
    [AuditDeleted]               TINYINT      NULL,
    [pkPSPJoinDocTypeFormFolder] DECIMAL (18) NOT NULL,
    [fkPSPDocType]               DECIMAL (18) NOT NULL,
    [fkFormFolder]               DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_PSPJoinDocTypeFormFolderAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkPSPJoinDocTypeFormFolderAudit]
    ON [dbo].[PSPJoinDocTypeFormFolderAudit]([pkPSPJoinDocTypeFormFolder] ASC);

