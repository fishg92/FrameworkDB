CREATE TABLE [dbo].[NotificationExclusionsAudit] (
    [pk]                       DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]           DATETIME      NULL,
    [AuditEndDate]             DATETIME      NULL,
    [AuditUser]                VARCHAR (50)  NULL,
    [AuditMachine]             VARCHAR (15)  NULL,
    [AuditDeleted]             TINYINT       NULL,
    [pkNotificationExclusions] INT           NOT NULL,
    [TableName]                VARCHAR (100) NULL,
    [fkApplicationUser]        INT           NOT NULL,
    [fkType]                   INT           NOT NULL,
    [TypePkName]               VARCHAR (50)  NULL,
    CONSTRAINT [PK_NotificationExclusionsAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkNotificationExclusionsAudit]
    ON [dbo].[NotificationExclusionsAudit]([pkNotificationExclusions] ASC);

