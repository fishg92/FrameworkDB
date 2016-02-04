CREATE TABLE [dbo].[JoinrefTaskTypeFormAudit] (
    [pk]                    DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]        DATETIME     NULL,
    [AuditEndDate]          DATETIME     NULL,
    [AuditUser]             VARCHAR (50) NULL,
    [AuditMachine]          VARCHAR (15) NULL,
    [AuditDeleted]          TINYINT      NULL,
    [pkJoinrefTaskTypeForm] DECIMAL (18) NOT NULL,
    [fkrefTaskType]         DECIMAL (18) NOT NULL,
    [fkFormName]            DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinrefTaskTypeFormAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinrefTaskTypeFormAudit]
    ON [dbo].[JoinrefTaskTypeFormAudit]([pkJoinrefTaskTypeForm] ASC);

