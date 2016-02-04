CREATE TABLE [dbo].[CPRefPhoneTypeAudit] (
    [pk]               DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]   DATETIME      NULL,
    [AuditEndDate]     DATETIME      NULL,
    [AuditUser]        VARCHAR (50)  NULL,
    [AuditMachine]     VARCHAR (15)  NULL,
    [AuditDeleted]     TINYINT       NULL,
    [pkCPRefPhoneType] DECIMAL (18)  NOT NULL,
    [Description]      VARCHAR (255) NULL,
    CONSTRAINT [PK_CPRefPhoneTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPRefPhoneTypeAudit]
    ON [dbo].[CPRefPhoneTypeAudit]([pkCPRefPhoneType] ASC);

