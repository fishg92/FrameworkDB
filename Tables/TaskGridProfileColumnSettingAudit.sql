CREATE TABLE [dbo].[TaskGridProfileColumnSettingAudit] (
    [pk]                             DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                 DATETIME      NULL,
    [AuditEndDate]                   DATETIME      NULL,
    [AuditUser]                      VARCHAR (50)  NULL,
    [AuditMachine]                   VARCHAR (15)  NULL,
    [AuditDeleted]                   TINYINT       NULL,
    [pkTaskGridProfileColumnSetting] DECIMAL (18)  NOT NULL,
    [fkProfile]                      DECIMAL (18)  NOT NULL,
    [SettingsData]                   VARCHAR (MAX) NULL,
    CONSTRAINT [PK_TaskGridProfileColumnSettingAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkTaskGridProfileColumnSettingAudit]
    ON [dbo].[TaskGridProfileColumnSettingAudit]([pkTaskGridProfileColumnSetting] ASC);

