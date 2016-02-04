CREATE TABLE [dbo].[ExternalDataSystemQueryAudit] (
    [pk]                        DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]            DATETIME      NULL,
    [AuditEndDate]              DATETIME      NULL,
    [AuditUser]                 VARCHAR (50)  NULL,
    [AuditMachine]              VARCHAR (15)  NULL,
    [AuditDeleted]              TINYINT       NULL,
    [pkExternalDataSystemQuery] DECIMAL (18)  NOT NULL,
    [fkApplicationUser]         DECIMAL (18)  NULL,
    [fkExternalDataSystem]      DECIMAL (18)  NULL,
    [Query]                     VARCHAR (MAX) NULL,
    CONSTRAINT [PK_ExternalDataSystemQueryAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkExternalDataSystemQueryAudit]
    ON [dbo].[ExternalDataSystemQueryAudit]([pkExternalDataSystemQuery] ASC);

