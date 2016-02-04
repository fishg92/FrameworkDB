CREATE TABLE [dbo].[AutoFillDataStoreAudit] (
    [pk]                  DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]      DATETIME      NULL,
    [AuditEndDate]        DATETIME      NULL,
    [AuditUser]           VARCHAR (50)  NULL,
    [AuditMachine]        VARCHAR (15)  NULL,
    [AuditDeleted]        TINYINT       NULL,
    [pkAutoFillDataStore] DECIMAL (18)  NOT NULL,
    [FriendlyName]        VARCHAR (100) NULL,
    [ConnectionType]      VARCHAR (100) NULL,
    [ConnectionString]    VARCHAR (500) NULL,
    [Enabled]             BIT           NULL,
    CONSTRAINT [PK_AutoFillDataStoreAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkAutoFillDataStoreAudit]
    ON [dbo].[AutoFillDataStoreAudit]([pkAutoFillDataStore] ASC);

