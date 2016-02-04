CREATE TABLE [dbo].[TaskGridColumnSettingAudit] (
    [pk]                      DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]          DATETIME      NULL,
    [AuditEndDate]            DATETIME      NULL,
    [AuditUser]               VARCHAR (50)  NULL,
    [AuditMachine]            VARCHAR (15)  NULL,
    [AuditDeleted]            TINYINT       NULL,
    [pkTaskGridColumnSetting] DECIMAL (18)  NOT NULL,
    [fkApplicationUser]       DECIMAL (18)  NOT NULL,
    [SettingsData]            VARCHAR (MAX) NULL,
    CONSTRAINT [PK_TaskGridColumnSettingAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkTaskGridColumnSettingAudit]
    ON [dbo].[TaskGridColumnSettingAudit]([pkTaskGridColumnSetting] ASC);

