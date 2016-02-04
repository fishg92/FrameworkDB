CREATE TABLE [dbo].[AutoFillDataSourceAudit] (
    [pk]                   DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]       DATETIME      NULL,
    [AuditEndDate]         DATETIME      NULL,
    [AuditUser]            VARCHAR (50)  NULL,
    [AuditMachine]         VARCHAR (15)  NULL,
    [AuditDeleted]         TINYINT       NULL,
    [pkAutoFillDataSource] DECIMAL (18)  NOT NULL,
    [fkAutoFillDataStore]  DECIMAL (18)  NOT NULL,
    [FriendlyName]         VARCHAR (100) NULL,
    [ProcName]             VARCHAR (100) NULL,
    CONSTRAINT [PK_AutoFillDataSourceAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkAutoFillDataSourceAudit]
    ON [dbo].[AutoFillDataSourceAudit]([pkAutoFillDataSource] ASC);

