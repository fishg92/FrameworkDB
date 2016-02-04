CREATE TABLE [dbo].[AgencyConfigAudit] (
    [pk]             DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME      NULL,
    [AuditEndDate]   DATETIME      NULL,
    [AuditUser]      VARCHAR (50)  NULL,
    [AuditMachine]   VARCHAR (15)  NULL,
    [AuditDeleted]   TINYINT       NULL,
    [pkAgencyConfig] DECIMAL (18)  NOT NULL,
    [AgencyName]     VARCHAR (100) NULL,
    [fkSupervisor]   DECIMAL (18)  CONSTRAINT [DF_AgencyConfigAudit_fkSupervisor] DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_AgencyConfigAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkAgencyConfigAudit]
    ON [dbo].[AgencyConfigAudit]([pkAgencyConfig] ASC);

