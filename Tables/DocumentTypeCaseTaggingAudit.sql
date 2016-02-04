CREATE TABLE [dbo].[DocumentTypeCaseTaggingAudit] (
    [pk]                        DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]            DATETIME     NULL,
    [AuditEndDate]              DATETIME     NULL,
    [AuditUser]                 VARCHAR (50) NULL,
    [AuditMachine]              VARCHAR (15) NULL,
    [AuditDeleted]              TINYINT      NULL,
    [pkDocumentTypeCaseTagging] DECIMAL (18) NOT NULL,
    [fkDocumentType]            VARCHAR (50) NULL,
    CONSTRAINT [PK_DocumentTypeCaseTaggingAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkDocumentTypeCaseTaggingAudit]
    ON [dbo].[DocumentTypeCaseTaggingAudit]([pkDocumentTypeCaseTagging] ASC);

