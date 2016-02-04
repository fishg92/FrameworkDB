CREATE TABLE [dbo].[CPJoinClientEmployerAudit] (
    [pk]                     DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]         DATETIME     NULL,
    [AuditEndDate]           DATETIME     NULL,
    [AuditUser]              VARCHAR (50) NULL,
    [AuditMachine]           VARCHAR (15) NULL,
    [AuditDeleted]           TINYINT      NULL,
    [pkCPJoinClientEmployer] DECIMAL (18) NOT NULL,
    [fkCPClient]             DECIMAL (18) NULL,
    [fkCPEmployer]           DECIMAL (18) NULL,
    [StartDate]              DATETIME     NULL,
    [EndDate]                DATETIME     NULL,
    [LockedUser]             VARCHAR (50) NULL,
    [LockedDate]             DATETIME     NULL,
    CONSTRAINT [PK_CPJoinClientEmployerAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPJoinClientEmployerAudit]
    ON [dbo].[CPJoinClientEmployerAudit]([pkCPJoinClientEmployer] ASC);

