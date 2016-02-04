CREATE TABLE [dbo].[CPRefClientCaseProgramTypeAudit] (
    [pk]                           DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]               DATETIME      NULL,
    [AuditEndDate]                 DATETIME      NULL,
    [AuditUser]                    VARCHAR (50)  NULL,
    [AuditMachine]                 VARCHAR (15)  NULL,
    [AuditDeleted]                 TINYINT       NULL,
    [pkCPRefClientCaseProgramType] DECIMAL (18)  NOT NULL,
    [Description]                  VARCHAR (100) NULL,
    CONSTRAINT [PK_CPRefClientCaseProgramTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPRefClientCaseProgramTypeAudit]
    ON [dbo].[CPRefClientCaseProgramTypeAudit]([pkCPRefClientCaseProgramType] ASC);

