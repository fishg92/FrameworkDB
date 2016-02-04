CREATE TABLE [dbo].[ScannedDocTypeMappingAudit] (
    [pk]                      DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]          DATETIME      NULL,
    [AuditEndDate]            DATETIME      NULL,
    [AuditUser]               VARCHAR (50)  NULL,
    [AuditMachine]            VARCHAR (15)  NULL,
    [AuditDeleted]            TINYINT       NULL,
    [pkScannedDocTypeMapping] DECIMAL (18)  NOT NULL,
    [ScannedDocType]          VARCHAR (100) NULL,
    [MappedDocType]           VARCHAR (100) NULL,
    CONSTRAINT [PK_ScannedDocTypeMappingAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkScannedDocTypeMappingAudit]
    ON [dbo].[ScannedDocTypeMappingAudit]([pkScannedDocTypeMapping] ASC);

