CREATE TABLE [dbo].[TaskFilterAudit] (
    [pk]             DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME      NULL,
    [AuditEndDate]   DATETIME      NULL,
    [AuditUser]      VARCHAR (50)  NULL,
    [AuditMachine]   VARCHAR (15)  NULL,
    [AuditDeleted]   TINYINT       NULL,
    [pkTaskFilter]   DECIMAL (18)  NOT NULL,
    [fkTaskView]     DECIMAL (18)  NULL,
    [ParentNode]     VARCHAR (100) NULL,
    [Node]           VARCHAR (100) NULL,
    [TaskTab]        VARCHAR (100) NULL,
    CONSTRAINT [PK_TaskFilterAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkTaskFilterAudit]
    ON [dbo].[TaskFilterAudit]([pkTaskFilter] ASC);

