CREATE TABLE [dbo].[DocumentDipFolderAudit] (
    [pk]                  DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]      DATETIME      NULL,
    [AuditEndDate]        DATETIME      NULL,
    [AuditUser]           VARCHAR (50)  NULL,
    [AuditMachine]        VARCHAR (15)  NULL,
    [AuditDeleted]        TINYINT       NULL,
    [pkDocumentDipFolder] DECIMAL (18)  NOT NULL,
    [fkApplication]       DECIMAL (18)  NOT NULL,
    [dipFolderPath]       VARCHAR (500) NULL,
    CONSTRAINT [PK_DocumentDipFolderAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkDocumentDipFolderAudit]
    ON [dbo].[DocumentDipFolderAudit]([pkDocumentDipFolder] ASC);

