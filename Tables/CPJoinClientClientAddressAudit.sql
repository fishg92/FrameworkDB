CREATE TABLE [dbo].[CPJoinClientClientAddressAudit] (
    [pk]                          DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]              DATETIME     NULL,
    [AuditEndDate]                DATETIME     NULL,
    [AuditUser]                   VARCHAR (50) NULL,
    [AuditMachine]                VARCHAR (15) NULL,
    [AuditDeleted]                TINYINT      NULL,
    [pkCPJoinClientClientAddress] DECIMAL (18) NOT NULL,
    [fkCPClient]                  DECIMAL (18) NULL,
    [fkCPClientAddress]           DECIMAL (18) NULL,
    [LockedUser]                  VARCHAR (50) NULL,
    [LockedDate]                  DATETIME     NULL,
    [fkCPRefClientAddressType]    DECIMAL (18) NULL,
    CONSTRAINT [PK_CPJoinClientClientAddressAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPJoinClientClientAddressAudit]
    ON [dbo].[CPJoinClientClientAddressAudit]([pkCPJoinClientClientAddress] ASC);


GO
CREATE NONCLUSTERED INDEX [idxfkCPClient]
    ON [dbo].[CPJoinClientClientAddressAudit]([fkCPClient] ASC);

