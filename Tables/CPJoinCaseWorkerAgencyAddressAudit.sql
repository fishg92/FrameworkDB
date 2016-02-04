CREATE TABLE [dbo].[CPJoinCaseWorkerAgencyAddressAudit] (
    [pk]                              DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                  DATETIME     NULL,
    [AuditEndDate]                    DATETIME     NULL,
    [AuditUser]                       VARCHAR (50) NULL,
    [AuditMachine]                    VARCHAR (15) NULL,
    [AuditDeleted]                    TINYINT      NULL,
    [pkCPJoinCaseWorkerAgencyAddress] DECIMAL (18) NOT NULL,
    [fkCPCaseWorker]                  DECIMAL (18) NULL,
    [fkCPAgencyAddress]               DECIMAL (18) NULL,
    [fkCPRefAgencyAddressType]        DECIMAL (18) NULL,
    CONSTRAINT [PK_CPJoinCaseWorkerAgencyAddressAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPJoinCaseWorkerAgencyAddressAudit]
    ON [dbo].[CPJoinCaseWorkerAgencyAddressAudit]([pkCPJoinCaseWorkerAgencyAddress] ASC);

