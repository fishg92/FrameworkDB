CREATE TABLE [dbo].[TaskFormCompletionAudit] (
    [pk]                   DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]       DATETIME     NULL,
    [AuditEndDate]         DATETIME     NULL,
    [AuditUser]            VARCHAR (50) NULL,
    [AuditMachine]         VARCHAR (15) NULL,
    [AuditDeleted]         TINYINT      NULL,
    [pkTaskFormCompletion] DECIMAL (18) NOT NULL,
    [fkTask]               VARCHAR (50) NULL,
    [fkCPClient]           DECIMAL (18) NOT NULL,
    [fkFormName]           DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_TaskFormCompletionAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkTaskFormCompletionAudit]
    ON [dbo].[TaskFormCompletionAudit]([pkTaskFormCompletion] ASC);

