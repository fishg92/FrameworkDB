CREATE TABLE [dbo].[refTaskTypeEscalationAudit] (
    [pk]                      DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]          DATETIME     NULL,
    [AuditEndDate]            DATETIME     NULL,
    [AuditUser]               VARCHAR (50) NULL,
    [AuditMachine]            VARCHAR (15) NULL,
    [AuditDeleted]            TINYINT      NULL,
    [pkrefTaskTypeEscalation] DECIMAL (18) NOT NULL,
    [fkrefTaskType]           DECIMAL (18) NOT NULL,
    [Sequence]                INT          NOT NULL,
    [MinutesAfterDueDate]     INT          NOT NULL,
    CONSTRAINT [PK_refTaskTypeEscalationAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkrefTaskTypeEscalationAudit]
    ON [dbo].[refTaskTypeEscalationAudit]([pkrefTaskTypeEscalation] ASC);

