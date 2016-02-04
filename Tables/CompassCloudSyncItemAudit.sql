CREATE TABLE [dbo].[CompassCloudSyncItemAudit] (
    [pk]                     DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]         DATETIME      NULL,
    [AuditEndDate]           DATETIME      NULL,
    [AuditUser]              VARCHAR (50)  NULL,
    [AuditEffectiveUser]     VARCHAR (50)  NULL,
    [AuditEffectiveDate]     DATETIME      NULL,
    [AuditMachine]           VARCHAR (15)  NULL,
    [AuditDeleted]           TINYINT       NULL,
    [pkCompassCloudSyncItem] DECIMAL (18)  NOT NULL,
    [fkSyncItem]             VARCHAR (50)  NOT NULL,
    [SyncItemType]           DECIMAL (18)  NOT NULL,
    [FormallyKnownAs]        VARCHAR (50)  NULL,
    [fkApplicationUser]      DECIMAL (18)  NOT NULL,
    [CloudItemID]            VARCHAR (250) CONSTRAINT [DF__CompassCl__Cloud__31BA9058] DEFAULT ('-1') NOT NULL,
    [TimeStamp]              FLOAT (53)    NOT NULL,
    [ItemPageNumber]         INT           NOT NULL,
    CONSTRAINT [PK_CompassCloudSyncItemAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCompassCloudSyncItemAudit]
    ON [dbo].[CompassCloudSyncItemAudit]([pkCompassCloudSyncItem] ASC);

