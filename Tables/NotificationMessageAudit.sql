CREATE TABLE [dbo].[NotificationMessageAudit] (
    [pk]                             DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                 DATETIME       NULL,
    [AuditEndDate]                   DATETIME       NULL,
    [AuditUser]                      VARCHAR (50)   NULL,
    [AuditMachine]                   VARCHAR (15)   NULL,
    [AuditDeleted]                   TINYINT        NULL,
    [pkNotificationMessage]          DECIMAL (18)   NOT NULL,
    [fkApplicationUser]              DECIMAL (18)   NOT NULL,
    [MessageDeliveryType]            INT            CONSTRAINT [DF__Notificat__Messa__2A4E78BA] DEFAULT ((2)) NOT NULL,
    [NCPApplicationSource]           INT            CONSTRAINT [DF__Notificat__NCPAp__2B429CF3] DEFAULT ((-1)) NOT NULL,
    [ShowBubbleSeconds]              INT            CONSTRAINT [DF__Notificat__ShowB__2C36C12C] DEFAULT ((-1)) NOT NULL,
    [MessageText]                    VARCHAR (200)  CONSTRAINT [DF__Notificat__Messa__2D2AE565] DEFAULT ('') NULL,
    [MessageTitle]                   VARCHAR (50)   NULL,
    [AuditEffectiveUser]             VARCHAR (50)   NULL,
    [AuditEffectiveDate]             DATETIME       NULL,
    [fkAssignedBy]                   DECIMAL (18)   CONSTRAINT [DF__Notificat__fkAss__2E1F099E] DEFAULT ((0)) NOT NULL,
    [fkTask]                         DECIMAL (18)   CONSTRAINT [DF__Notificat__fkTas__2F132DD7] DEFAULT ((0)) NOT NULL,
    [UseToastNotification]           BIT            CONSTRAINT [DF__Notificat__UseTo__30075210] DEFAULT ((0)) NOT NULL,
    [ClientNamesList]                NVARCHAR (510) CONSTRAINT [DF__Notificat__Clien__30FB7649] DEFAULT ('') NOT NULL,
    [IsNotificationForAssigningUser] BIT            CONSTRAINT [DF__Notificat__IsNot__31EF9A82] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_NotificationMessageAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkNotificationMessageAudit]
    ON [dbo].[NotificationMessageAudit]([pkNotificationMessage] ASC);

