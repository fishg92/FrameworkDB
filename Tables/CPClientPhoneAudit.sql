CREATE TABLE [dbo].[CPClientPhoneAudit] (
    [pk]               DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]   DATETIME     NULL,
    [AuditEndDate]     DATETIME     NULL,
    [AuditUser]        VARCHAR (50) NULL,
    [AuditMachine]     VARCHAR (15) NULL,
    [AuditDeleted]     TINYINT      NULL,
    [pkCPClientPhone]  DECIMAL (18) NOT NULL,
    [fkCPRefPhoneType] DECIMAL (18) NULL,
    [Number]           VARCHAR (10) NULL,
    [Extension]        VARCHAR (10) NULL,
    [LockedUser]       VARCHAR (50) NULL,
    [LockedDate]       DATETIME     NULL,
    CONSTRAINT [PK_CPClientPhoneAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPClientPhoneAudit]
    ON [dbo].[CPClientPhoneAudit]([pkCPClientPhone] ASC);

