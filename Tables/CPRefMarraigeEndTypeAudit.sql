CREATE TABLE [dbo].[CPRefMarraigeEndTypeAudit] (
    [pk]                     DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]         DATETIME      NULL,
    [AuditEndDate]           DATETIME      NULL,
    [AuditUser]              VARCHAR (50)  NULL,
    [AuditMachine]           VARCHAR (15)  NULL,
    [AuditDeleted]           TINYINT       NULL,
    [pkCPRefMarraigeEndType] DECIMAL (18)  NOT NULL,
    [Description]            VARCHAR (100) NULL,
    CONSTRAINT [PK_CPRefMarraigeEndTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPRefMarraigeEndTypeAudit]
    ON [dbo].[CPRefMarraigeEndTypeAudit]([pkCPRefMarraigeEndType] ASC);

