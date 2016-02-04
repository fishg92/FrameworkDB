CREATE TABLE [dbo].[CPJoinCaseWorkerCaseWorkerPhoneAudit] (
    [pk]                                DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                    DATETIME     NULL,
    [AuditEndDate]                      DATETIME     NULL,
    [AuditUser]                         VARCHAR (50) NULL,
    [AuditMachine]                      VARCHAR (15) NULL,
    [AuditDeleted]                      TINYINT      NULL,
    [pkCPJoinCaseWorkerCaseWorkerPhone] DECIMAL (18) NOT NULL,
    [fkCPCaseWorker]                    DECIMAL (18) NULL,
    [fkCPCaseWorkerPhone]               DECIMAL (18) NULL,
    [fkCPRefPhoneType]                  DECIMAL (18) NULL,
    CONSTRAINT [PK_CPJoinCaseWorkerCaseWorkerPhoneAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPJoinCaseWorkerCaseWorkerPhoneAudit]
    ON [dbo].[CPJoinCaseWorkerCaseWorkerPhoneAudit]([pkCPJoinCaseWorkerCaseWorkerPhone] ASC);

