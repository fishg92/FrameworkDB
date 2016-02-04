CREATE TABLE [dbo].[DocumentTypeGroupKeywordTypeTabDisplaySettingAudit] (
    [pk]                                              DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                                  DATETIME     NULL,
    [AuditEndDate]                                    DATETIME     NULL,
    [AuditUser]                                       VARCHAR (50) NULL,
    [AuditMachine]                                    VARCHAR (15) NULL,
    [AuditDeleted]                                    TINYINT      NULL,
    [pkDocumentTypeGroupKeywordTypeTabDisplaySetting] DECIMAL (18) NOT NULL,
    [fkDocumentTypeGroup]                             DECIMAL (18) NULL,
    [fkKeywordType]                                   VARCHAR (50) NULL,
    [Sequence]                                        INT          NOT NULL,
    CONSTRAINT [PK_DocumentTypeGroupKeywordTypeTabDisplaySettingAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkDocumentTypeGroupKeywordTypeTabDisplaySettingAudit]
    ON [dbo].[DocumentTypeGroupKeywordTypeTabDisplaySettingAudit]([pkDocumentTypeGroupKeywordTypeTabDisplaySetting] ASC);

