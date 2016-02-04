CREATE TABLE [dbo].[CPRefAlertFlagTypeNTAudit] (
    [pk]                     DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]         DATETIME      NULL,
    [AuditEndDate]           DATETIME      NULL,
    [AuditUser]              VARCHAR (50)  NULL,
    [AuditMachine]           VARCHAR (15)  NULL,
    [AuditDeleted]           TINYINT       NULL,
    [pkCPRefAlertFlagTypeNT] DECIMAL (18)  NOT NULL,
    [Description]            VARCHAR (255) NULL,
    [AlertDisplay]           BIT           NULL,
    [LockedUser]             VARCHAR (20)  NULL,
    [LockedDate]             DATETIME      NULL,
    CONSTRAINT [PK_CPRefAlertFlagTypeNTAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPRefAlertFlagTypeNTAudit]
    ON [dbo].[CPRefAlertFlagTypeNTAudit]([pkCPRefAlertFlagTypeNT] ASC);

