CREATE TABLE [dbo].[CPJoinClientClientPhoneAudit] (
    [pk]                        DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]            DATETIME     NULL,
    [AuditEndDate]              DATETIME     NULL,
    [AuditUser]                 VARCHAR (50) NULL,
    [AuditMachine]              VARCHAR (15) NULL,
    [AuditDeleted]              TINYINT      NULL,
    [pkCPJoinClientClientPhone] DECIMAL (18) NOT NULL,
    [fkCPClient]                DECIMAL (18) NULL,
    [fkCPClientPhone]           DECIMAL (18) NULL,
    [LockedUser]                VARCHAR (50) NULL,
    [LockedDate]                DATETIME     NULL,
    [fkCPRefPhoneType]          DECIMAL (18) NULL,
    CONSTRAINT [PK_CPJoinClientClientPhoneAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPJoinClientClientPhoneAudit]
    ON [dbo].[CPJoinClientClientPhoneAudit]([pkCPJoinClientClientPhone] ASC);

