CREATE TABLE [dbo].[JoinEventTypeFormNameAudit] (
    [pk]                      DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]          DATETIME     NULL,
    [AuditEndDate]            DATETIME     NULL,
    [AuditUser]               VARCHAR (50) NULL,
    [AuditMachine]            VARCHAR (15) NULL,
    [AuditDeleted]            TINYINT      NULL,
    [pkJoinEventTypeFormName] DECIMAL (18) NOT NULL,
    [fkEventType]             DECIMAL (18) NULL,
    [fkFormName]              DECIMAL (18) NULL,
    CONSTRAINT [PK_JoinEventTypeFormNameAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinEventTypeFormNameAudit]
    ON [dbo].[JoinEventTypeFormNameAudit]([pkJoinEventTypeFormName] ASC);

