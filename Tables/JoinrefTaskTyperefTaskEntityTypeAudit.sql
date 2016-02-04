CREATE TABLE [dbo].[JoinrefTaskTyperefTaskEntityTypeAudit] (
    [pk]                                 DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                     DATETIME     NULL,
    [AuditEndDate]                       DATETIME     NULL,
    [AuditUser]                          VARCHAR (50) NULL,
    [AuditMachine]                       VARCHAR (15) NULL,
    [AuditDeleted]                       TINYINT      NULL,
    [pkJoinrefTaskTyperefTaskEntityType] DECIMAL (18) NOT NULL,
    [fkrefTaskType]                      DECIMAL (18) NOT NULL,
    [fkrefTaskEntityType]                DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinrefTaskTyperefTaskEntityTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinrefTaskTyperefTaskEntityTypeAudit]
    ON [dbo].[JoinrefTaskTyperefTaskEntityTypeAudit]([pkJoinrefTaskTyperefTaskEntityType] ASC);

