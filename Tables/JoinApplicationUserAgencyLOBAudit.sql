CREATE TABLE [dbo].[JoinApplicationUserAgencyLOBAudit] (
    [pk]                             DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                 DATETIME     NULL,
    [AuditEndDate]                   DATETIME     NULL,
    [AuditUser]                      VARCHAR (50) NULL,
    [AuditMachine]                   VARCHAR (15) NULL,
    [AuditDeleted]                   TINYINT      NULL,
    [pkJoinApplicationUserAgencyLOB] DECIMAL (18) NOT NULL,
    [fkApplicationUser]              DECIMAL (18) NOT NULL,
    [fkAgencyLOB]                    DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinApplicationUserAgencyLOBAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinApplicationUserAgencyLOBAudit]
    ON [dbo].[JoinApplicationUserAgencyLOBAudit]([pkJoinApplicationUserAgencyLOB] ASC);

