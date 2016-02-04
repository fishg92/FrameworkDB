CREATE TABLE [dbo].[CPClientCaseAudit] (
    [pk]                           DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]               DATETIME     NULL,
    [AuditEndDate]                 DATETIME     NULL,
    [AuditUser]                    VARCHAR (50) NULL,
    [AuditMachine]                 VARCHAR (15) NULL,
    [AuditDeleted]                 TINYINT      NULL,
    [pkCPClientCase]               DECIMAL (18) NOT NULL,
    [StateCaseNumber]              VARCHAR (20) NULL,
    [LocalCaseNumber]              VARCHAR (20) NULL,
    [fkCPRefClientCaseProgramType] DECIMAL (18) NULL,
    [fkCPCaseWorker]               DECIMAL (18) NULL,
    [LockedUser]                   VARCHAR (50) NULL,
    [LockedDate]                   DATETIME     NULL,
    [fkCPClientCaseHead]           DECIMAL (18) NULL,
    [fkApplicationUser]            DECIMAL (18) NULL,
    [DistrictId]                   VARCHAR (50) NULL,
    [CaseStatus]                   BIT          CONSTRAINT [DF_CPClientCaseAudit_CaseStatus] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_CPClientCaseAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPClientCaseAudit]
    ON [dbo].[CPClientCaseAudit]([pkCPClientCase] ASC);

