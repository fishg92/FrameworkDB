CREATE TABLE [dbo].[AgencyLOBAudit] (
    [pk]             DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME      NULL,
    [AuditEndDate]   DATETIME      NULL,
    [AuditUser]      VARCHAR (50)  NULL,
    [AuditMachine]   VARCHAR (15)  NULL,
    [AuditDeleted]   TINYINT       NULL,
    [pkAgencyLOB]    DECIMAL (18)  NOT NULL,
    [AgencyLOBName]  VARCHAR (100) NULL,
    [fkAgency]       DECIMAL (18)  NOT NULL,
    [fkSupervisor]   DECIMAL (18)  CONSTRAINT [DF_AgencyLOBAudit_fkSupervisor] DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_AgencyLOBAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkAgencyLOBAudit]
    ON [dbo].[AgencyLOBAudit]([pkAgencyLOB] ASC);

