CREATE TABLE [dbo].[ProfileSettingAudit] (
    [pk]               DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]   DATETIME      NULL,
    [AuditEndDate]     DATETIME      NULL,
    [AuditUser]        VARCHAR (50)  NULL,
    [AuditMachine]     VARCHAR (15)  NULL,
    [AuditDeleted]     TINYINT       NULL,
    [pkProfileSetting] DECIMAL (18)  NOT NULL,
    [Grouping]         VARCHAR (200) NULL,
    [ItemKey]          VARCHAR (200) NULL,
    [ItemValue]        VARCHAR (MAX) NULL,
    [AppID]            INT           NOT NULL,
    [fkProfile]        DECIMAL (18)  NOT NULL,
    CONSTRAINT [PK_ProfileSettingAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkProfileSettingAudit]
    ON [dbo].[ProfileSettingAudit]([pkProfileSetting] ASC);

