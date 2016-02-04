CREATE TABLE [dbo].[CPCaseActivityAudit] (
    [pk]                   DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]       DATETIME      NULL,
    [AuditEndDate]         DATETIME      NULL,
    [AuditUser]            VARCHAR (50)  NULL,
    [AuditMachine]         VARCHAR (15)  NULL,
    [AuditDeleted]         TINYINT       NULL,
    [pkCPCaseActivity]     DECIMAL (18)  NOT NULL,
    [fkCPCaseActivityType] DECIMAL (18)  NULL,
    [fkCPClientCase]       DECIMAL (18)  NULL,
    [Description]          VARCHAR (MAX) NULL,
    [fkCPClient]           DECIMAL (18)  NULL,
    [EffectiveCreateDate]  DATETIME      NULL,
    CONSTRAINT [PK_CPCaseActivityAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPCaseActivityAudit]
    ON [dbo].[CPCaseActivityAudit]([pkCPCaseActivity] ASC);

