CREATE TABLE [dbo].[NotificationMessageActionAudit] (
    [pk]                          DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]              DATETIME      NULL,
    [AuditEndDate]                DATETIME      NULL,
    [AuditUser]                   VARCHAR (50)  NULL,
    [AuditMachine]                VARCHAR (15)  NULL,
    [AuditDeleted]                TINYINT       NULL,
    [pkNotificationMessageAction] DECIMAL (18)  NOT NULL,
    [fkNotificationMessage]       DECIMAL (18)  NOT NULL,
    [ActionKey]                   VARCHAR (255) NULL,
    [ActionValue]                 VARCHAR (255) NULL,
    CONSTRAINT [PK_NotificationMessageActionAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkNotificationMessageActionAudit]
    ON [dbo].[NotificationMessageActionAudit]([pkNotificationMessageAction] ASC);

