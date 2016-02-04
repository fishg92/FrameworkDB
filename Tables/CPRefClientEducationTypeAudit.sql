CREATE TABLE [dbo].[CPRefClientEducationTypeAudit] (
    [pk]                         DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]             DATETIME      NULL,
    [AuditEndDate]               DATETIME      NULL,
    [AuditUser]                  VARCHAR (50)  NULL,
    [AuditMachine]               VARCHAR (15)  NULL,
    [AuditDeleted]               TINYINT       NULL,
    [pkCPRefClientEducationType] DECIMAL (18)  NOT NULL,
    [Description]                VARCHAR (255) NULL,
    CONSTRAINT [PK_CPRefClientEducationTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPRefClientEducationTypeAudit]
    ON [dbo].[CPRefClientEducationTypeAudit]([pkCPRefClientEducationType] ASC);

