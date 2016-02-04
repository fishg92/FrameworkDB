CREATE TABLE [dbo].[ApplicationUserCustomAttributeAudit] (
    [pk]                               DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                   DATETIME      NULL,
    [AuditEndDate]                     DATETIME      NULL,
    [AuditUser]                        VARCHAR (50)  NULL,
    [AuditMachine]                     VARCHAR (15)  NULL,
    [AuditDeleted]                     TINYINT       NULL,
    [pkApplicationUserCustomAttribute] DECIMAL (18)  NOT NULL,
    [fkApplicationUser]                DECIMAL (18)  NOT NULL,
    [ItemKey]                          VARCHAR (200) NULL,
    [ItemValue]                        VARCHAR (300) NULL,
    CONSTRAINT [PK_ApplicationUserCustomAttributeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkApplicationUserCustomAttributeAudit]
    ON [dbo].[ApplicationUserCustomAttributeAudit]([pkApplicationUserCustomAttribute] ASC);

