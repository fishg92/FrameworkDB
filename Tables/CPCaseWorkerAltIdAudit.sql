CREATE TABLE [dbo].[CPCaseWorkerAltIdAudit] (
    [pk]                  DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]      DATETIME     NULL,
    [AuditEndDate]        DATETIME     NULL,
    [AuditUser]           VARCHAR (50) NULL,
    [AuditMachine]        VARCHAR (15) NULL,
    [AuditDeleted]        TINYINT      NULL,
    [pkCPCaseWorkerAltId] DECIMAL (18) NOT NULL,
    [fkCPCaseWorker]      DECIMAL (18) NULL,
    [WorkerId]            VARCHAR (50) NULL,
    [LockedDate]          DATETIME     NULL,
    [LockedUser]          VARCHAR (50) NULL,
    [fkApplicationUser]   DECIMAL (18) NULL,
    CONSTRAINT [PK_CPCaseWorkerAltIdAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPCaseWorkerAltIdAudit]
    ON [dbo].[CPCaseWorkerAltIdAudit]([pkCPCaseWorkerAltId] ASC);

