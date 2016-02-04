CREATE TABLE [dbo].[refFatalExceptionAudit] (
    [pk]                  DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]      DATETIME       NULL,
    [AuditEndDate]        DATETIME       NULL,
    [AuditUser]           VARCHAR (50)   NULL,
    [AuditMachine]        VARCHAR (15)   NULL,
    [AuditDeleted]        TINYINT        NULL,
    [pkrefFatalException] DECIMAL (18)   NOT NULL,
    [Message]             VARCHAR (1000) NULL,
    CONSTRAINT [PK_refFatalExceptionAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkrefFatalExceptionAudit]
    ON [dbo].[refFatalExceptionAudit]([pkrefFatalException] ASC);

