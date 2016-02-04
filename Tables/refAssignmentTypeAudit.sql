CREATE TABLE [dbo].[refAssignmentTypeAudit] (
    [pk]                  DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]      DATETIME      NULL,
    [AuditEndDate]        DATETIME      NULL,
    [AuditUser]           VARCHAR (50)  NULL,
    [AuditMachine]        VARCHAR (15)  NULL,
    [AuditDeleted]        TINYINT       NULL,
    [pkrefAssignmentType] DECIMAL (18)  NOT NULL,
    [Description]         VARCHAR (100) NULL,
    CONSTRAINT [PK_refAssignmentTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkrefAssignmentTypeAudit]
    ON [dbo].[refAssignmentTypeAudit]([pkrefAssignmentType] ASC);

