CREATE TABLE [dbo].[ConnectTypeAudit] (
    [pk]               DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]   DATETIME      NULL,
    [AuditEndDate]     DATETIME      NULL,
    [AuditUser]        VARCHAR (50)  NULL,
    [AuditMac]         CHAR (17)     NULL,
    [AuditIP]          VARCHAR (15)  NULL,
    [AuditMachine]     VARCHAR (15)  NULL,
    [AuditDeleted]     TINYINT       NULL,
    [pkConnectType]    DECIMAL (18)  NOT NULL,
    [Description]      VARCHAR (250) NULL,
    [EnableCloudSync]  BIT           NULL,
    [SyncInterval]     INT           NULL,
    [SyncProviderType] VARCHAR (50)  NULL,
    CONSTRAINT [PK_ConnectTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkConnectTypeAudit]
    ON [dbo].[ConnectTypeAudit]([pkConnectType] ASC);

