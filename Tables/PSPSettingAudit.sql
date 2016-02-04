CREATE TABLE [dbo].[PSPSettingAudit] (
    [pk]             DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME      NULL,
    [AuditEndDate]   DATETIME      NULL,
    [AuditUser]      VARCHAR (50)  NULL,
    [AuditMachine]   VARCHAR (15)  NULL,
    [AuditDeleted]   TINYINT       NULL,
    [pkPSPSetting]   DECIMAL (18)  NOT NULL,
    [SettingName]    VARCHAR (200) NULL,
    [SettingValue]   VARCHAR (500) NULL,
    CONSTRAINT [PK_PSPSettingAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkPSPSettingAudit]
    ON [dbo].[PSPSettingAudit]([pkPSPSetting] ASC);

