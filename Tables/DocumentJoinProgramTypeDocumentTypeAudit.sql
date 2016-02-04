CREATE TABLE [dbo].[DocumentJoinProgramTypeDocumentTypeAudit] (
    [pk]                                    DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                        DATETIME     NULL,
    [AuditEndDate]                          DATETIME     NULL,
    [AuditUser]                             VARCHAR (50) NULL,
    [AuditMachine]                          VARCHAR (15) NULL,
    [AuditDeleted]                          TINYINT      NULL,
    [pkDocumentJoinProgramTypeDocumentType] DECIMAL (18) NOT NULL,
    [fkProgramType]                         DECIMAL (18) NOT NULL,
    [fkDocumentType]                        VARCHAR (50) NULL,
    CONSTRAINT [PK_DocumentJoinProgramTypeDocumentTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkDocumentJoinProgramTypeDocumentTypeAudit]
    ON [dbo].[DocumentJoinProgramTypeDocumentTypeAudit]([pkDocumentJoinProgramTypeDocumentType] ASC);

