CREATE TABLE [dbo].[DocumentTypeGroupDisplaySettingAudit] (
    [pk]                                DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                    DATETIME     NULL,
    [AuditEndDate]                      DATETIME     NULL,
    [AuditUser]                         VARCHAR (50) NULL,
    [AuditMachine]                      VARCHAR (15) NULL,
    [AuditDeleted]                      TINYINT      NULL,
    [pkDocumentTypeGroupDisplaySetting] DECIMAL (18) NOT NULL,
    [fkDocumentTypeGroup]               VARCHAR (50) NOT NULL,
    [DisplayColor]                      INT          NOT NULL,
    [Sequence]                          INT          NOT NULL,
    CONSTRAINT [PK_DocumentTypeGroupDisplaySettingAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkDocumentTypeGroupDisplaySettingAudit]
    ON [dbo].[DocumentTypeGroupDisplaySettingAudit]([pkDocumentTypeGroupDisplaySetting] ASC);

