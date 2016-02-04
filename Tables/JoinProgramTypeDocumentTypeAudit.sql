CREATE TABLE [dbo].[JoinProgramTypeDocumentTypeAudit] (
    [pk]                            DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                DATETIME     NULL,
    [AuditEndDate]                  DATETIME     NULL,
    [AuditUser]                     VARCHAR (50) NULL,
    [AuditMachine]                  VARCHAR (15) NULL,
    [AuditDeleted]                  TINYINT      NULL,
    [pkJoinProgramTypeDocumentType] DECIMAL (18) NOT NULL,
    [fkProgramType]                 DECIMAL (18) NOT NULL,
    [fkDocumentType]                VARCHAR (50) NULL,
    CONSTRAINT [PK_JoinProgramTypeDocumentTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinProgramTypeDocumentTypeAudit]
    ON [dbo].[JoinProgramTypeDocumentTypeAudit]([pkJoinProgramTypeDocumentType] ASC);

