CREATE TABLE [dbo].[CPPointInTimeSearchSettingAudit] (
    [pk]                           DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]               DATETIME     NULL,
    [AuditEndDate]                 DATETIME     NULL,
    [AuditUser]                    VARCHAR (50) NULL,
    [AuditMachine]                 VARCHAR (15) NULL,
    [AuditDeleted]                 TINYINT      NULL,
    [pkCPPointInTimeSearchSetting] DECIMAL (18) NOT NULL,
    [fkDocumentType]               VARCHAR (50) NULL,
    [DaysBefore]                   INT          NOT NULL,
    [DaysAfter]                    INT          NOT NULL,
    CONSTRAINT [PK_CPPointInTimeSearchSettingAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPPointInTimeSearchSettingAudit]
    ON [dbo].[CPPointInTimeSearchSettingAudit]([pkCPPointInTimeSearchSetting] ASC);

