CREATE TABLE [dbo].[ExternalDataSystemResultAudit] (
    [pk]                         DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]             DATETIME        NULL,
    [AuditEndDate]               DATETIME        NULL,
    [AuditUser]                  VARCHAR (50)    NULL,
    [AuditMachine]               VARCHAR (15)    NULL,
    [AuditDeleted]               TINYINT         NULL,
    [pkExternalDataSystemResult] DECIMAL (18)    NOT NULL,
    [fkExternalDataSystemQuery]  DECIMAL (18)    NULL,
    [RawResult]                  VARBINARY (MAX) NULL,
    [ProcessedResult]            VARBINARY (MAX) NULL,
    [Status]                     INT             NULL,
    CONSTRAINT [PK_ExternalDataSystemResultAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkExternalDataSystemResultAudit]
    ON [dbo].[ExternalDataSystemResultAudit]([pkExternalDataSystemResult] ASC);

