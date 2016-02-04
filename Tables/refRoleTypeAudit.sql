CREATE TABLE [dbo].[refRoleTypeAudit] (
    [pk]             DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME     NULL,
    [AuditEndDate]   DATETIME     NULL,
    [AuditUser]      VARCHAR (50) NULL,
    [AuditMachine]   VARCHAR (15) NULL,
    [AuditDeleted]   TINYINT      NULL,
    [pkrefRoleType]  DECIMAL (18) NOT NULL,
    [Description]    VARCHAR (50) NULL,
    CONSTRAINT [PK_refRoleTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkrefRoleTypeAudit]
    ON [dbo].[refRoleTypeAudit]([pkrefRoleType] ASC);

