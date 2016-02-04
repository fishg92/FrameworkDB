CREATE TABLE [dbo].[CPCaseActivityTypeAudit] (
    [pk]                   DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]       DATETIME      NULL,
    [AuditEndDate]         DATETIME      NULL,
    [AuditUser]            VARCHAR (50)  NULL,
    [AuditMachine]         VARCHAR (15)  NULL,
    [AuditDeleted]         TINYINT       NULL,
    [pkCPCaseActivityType] DECIMAL (18)  NOT NULL,
    [Description]          VARCHAR (100) NULL,
    CONSTRAINT [PK_CPCaseActivityTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPCaseActivityTypeAudit]
    ON [dbo].[CPCaseActivityTypeAudit]([pkCPCaseActivityType] ASC);

