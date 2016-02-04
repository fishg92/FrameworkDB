CREATE TABLE [dbo].[LDAPDomainAudit] (
    [pk]             DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME      NULL,
    [AuditEndDate]   DATETIME      NULL,
    [AuditUser]      VARCHAR (50)  NULL,
    [AuditMachine]   VARCHAR (15)  NULL,
    [AuditDeleted]   TINYINT       NULL,
    [pkLDAPDomain]   INT           NOT NULL,
    [Domain]         VARCHAR (255) NULL,
    [LDAPUsername]   VARCHAR (100) NULL,
    [LDAPPassword]   VARCHAR (100) NULL,
    CONSTRAINT [PK_LDAPDomainAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkLDAPDomainAudit]
    ON [dbo].[LDAPDomainAudit]([pkLDAPDomain] ASC);

