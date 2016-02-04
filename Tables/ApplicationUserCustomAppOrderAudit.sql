CREATE TABLE [dbo].[ApplicationUserCustomAppOrderAudit] (
    [pk]                              DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                  DATETIME     NULL,
    [AuditEndDate]                    DATETIME     NULL,
    [AuditUser]                       VARCHAR (50) NULL,
    [AuditMachine]                    VARCHAR (15) NULL,
    [AuditDeleted]                    TINYINT      NULL,
    [pkApplicationUserCustomAppOrder] DECIMAL (18) NOT NULL,
    [fkApplicationUser]               DECIMAL (18) NOT NULL,
    [fkNCPApplication]                DECIMAL (18) NOT NULL,
    [AppLoadOrder]                    INT          NOT NULL,
    CONSTRAINT [PK_ApplicationUserCustomAppOrderAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkApplicationUserCustomAppOrderAudit]
    ON [dbo].[ApplicationUserCustomAppOrderAudit]([pkApplicationUserCustomAppOrder] ASC);

