CREATE TABLE [dbo].[CPCaseWorkerPhoneAudit] (
    [pk]                  DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]      DATETIME     NULL,
    [AuditEndDate]        DATETIME     NULL,
    [AuditUser]           VARCHAR (50) NULL,
    [AuditMachine]        VARCHAR (15) NULL,
    [AuditDeleted]        TINYINT      NULL,
    [pkCPCaseWorkerPhone] DECIMAL (18) NOT NULL,
    [fkCPRefPhoneType]    DECIMAL (18) NULL,
    [Number]              VARCHAR (10) NULL,
    [Extension]           VARCHAR (10) NULL,
    CONSTRAINT [PK_CPCaseWorkerPhoneAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPCaseWorkerPhoneAudit]
    ON [dbo].[CPCaseWorkerPhoneAudit]([pkCPCaseWorkerPhone] ASC);

