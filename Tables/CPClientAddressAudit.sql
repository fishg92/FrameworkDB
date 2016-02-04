CREATE TABLE [dbo].[CPClientAddressAudit] (
    [pk]                       DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]           DATETIME      NULL,
    [AuditEndDate]             DATETIME      NULL,
    [AuditUser]                VARCHAR (50)  NULL,
    [AuditMachine]             VARCHAR (15)  NULL,
    [AuditDeleted]             TINYINT       NULL,
    [pkCPClientAddress]        DECIMAL (18)  NOT NULL,
    [fkCPRefClientAddressType] DECIMAL (18)  NULL,
    [Street1]                  VARCHAR (100) NULL,
    [Street2]                  VARCHAR (100) NULL,
    [Street3]                  VARCHAR (100) NULL,
    [City]                     VARCHAR (100) NULL,
    [State]                    VARCHAR (50)  NULL,
    [Zip]                      CHAR (5)      NULL,
    [ZipPlus4]                 CHAR (4)      NULL,
    [LockedUser]               VARCHAR (50)  NULL,
    [LockedDate]               DATETIME      NULL,
    CONSTRAINT [PK_CPClientAddressAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPClientAddressAudit]
    ON [dbo].[CPClientAddressAudit]([pkCPClientAddress] ASC);

