CREATE TABLE [dbo].[LogEntryTypeAudit] (
    [pk]             DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME     NULL,
    [AuditEndDate]   DATETIME     NULL,
    [AuditUser]      VARCHAR (50) NULL,
    [AuditMachine]   VARCHAR (15) NULL,
    [AuditDeleted]   TINYINT      NULL,
    [pkLogEntryType] INT          NOT NULL,
    [EntryID]        INT          NULL,
    [EntryName]      VARCHAR (50) NULL,
    CONSTRAINT [PK_LogEntryTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkLogEntryTypeAudit]
    ON [dbo].[LogEntryTypeAudit]([pkLogEntryType] ASC);

