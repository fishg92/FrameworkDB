CREATE TABLE [dbo].[DocumentTypeDisplaySettingAudit] (
    [pk]                                DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                    DATETIME      NULL,
    [AuditEndDate]                      DATETIME      NULL,
    [AuditUser]                         VARCHAR (50)  NULL,
    [AuditMachine]                      VARCHAR (15)  NULL,
    [AuditDeleted]                      TINYINT       NULL,
    [pkDocumentTypeDisplaySetting]      DECIMAL (18)  NOT NULL,
    [fkDocumentType]                    VARCHAR (50)  NULL,
    [NumberOfDisplayedDocs]             INT           CONSTRAINT [DF_DocumentTypeDisplaySettingAudit_NumberOfDisplayedDocs] DEFAULT ((0)) NOT NULL,
    [DateRangeDay]                      INT           CONSTRAINT [DF_DocumentTypeDisplaySettingAudit_DateRangeDay] DEFAULT ((0)) NOT NULL,
    [DateRangeMonth]                    INT           CONSTRAINT [DF_DocumentTypeDisplaySettingAudit_DateRangeMonth] DEFAULT ((0)) NOT NULL,
    [DateRangeYear]                     INT           CONSTRAINT [DF_DocumentTypeDisplaySettingAudit_DateRangeYear] DEFAULT ((0)) NOT NULL,
    [fkDocumentOverlay]                 DECIMAL (18)  NULL,
    [fkTaskType]                        DECIMAL (18)  NULL,
    [DocTypeDescription_SupportUseOnly] VARCHAR (500) CONSTRAINT [DF__DocumentT__Descr__07A45AFB] DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_DocumentTypeDisplaySettingAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkDocumentTypeDisplaySettingAudit]
    ON [dbo].[DocumentTypeDisplaySettingAudit]([pkDocumentTypeDisplaySetting] ASC);

