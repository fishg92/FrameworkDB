CREATE TABLE [dbo].[JoinProfileDocumentTypeAudit] (
    [pk]                        DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]            DATETIME     NULL,
    [AuditEndDate]              DATETIME     NULL,
    [AuditUser]                 VARCHAR (50) NULL,
    [AuditMachine]              VARCHAR (15) NULL,
    [AuditDeleted]              TINYINT      NULL,
    [pkJoinProfileDocumentType] DECIMAL (18) NOT NULL,
    [fkProfile]                 DECIMAL (18) NOT NULL,
    [fkDocumentType]            VARCHAR (50) NULL,
    CONSTRAINT [PK_JoinProfileDocumentTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinProfileDocumentTypeAudit]
    ON [dbo].[JoinProfileDocumentTypeAudit]([pkJoinProfileDocumentType] ASC);

