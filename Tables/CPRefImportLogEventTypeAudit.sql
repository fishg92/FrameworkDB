CREATE TABLE [dbo].[CPRefImportLogEventTypeAudit] (
    [pk]                        DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]            DATETIME     NULL,
    [AuditEndDate]              DATETIME     NULL,
    [AuditUser]                 VARCHAR (50) NULL,
    [AuditMachine]              VARCHAR (15) NULL,
    [AuditDeleted]              TINYINT      NULL,
    [pkCPRefImportLogEventType] DECIMAL (18) NOT NULL,
    [EventType]                 VARCHAR (50) NULL,
    CONSTRAINT [PK_CPRefImportLogEventTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPRefImportLogEventTypeAudit]
    ON [dbo].[CPRefImportLogEventTypeAudit]([pkCPRefImportLogEventType] ASC);

