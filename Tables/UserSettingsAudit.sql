CREATE TABLE [dbo].[UserSettingsAudit] (
    [pk]                DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]    DATETIME      NULL,
    [AuditEndDate]      DATETIME      NULL,
    [AuditUser]         VARCHAR (50)  NULL,
    [AuditMachine]      VARCHAR (15)  NULL,
    [AuditDeleted]      TINYINT       NULL,
    [pkUserSettings]    DECIMAL (18)  NOT NULL,
    [fkApplicationUser] DECIMAL (18)  NOT NULL,
    [Grouping]          VARCHAR (200) NULL,
    [ItemKey]           VARCHAR (200) NULL,
    [ItemValue]         VARCHAR (600) NULL,
    [ItemDescription]   VARCHAR (300) NULL,
    [AppID]             INT           NOT NULL,
    [Sequence]          BIGINT        NOT NULL,
    CONSTRAINT [PK_UserSettingsAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkUserSettingsAudit]
    ON [dbo].[UserSettingsAudit]([pkUserSettings] ASC);

