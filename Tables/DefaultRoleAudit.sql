CREATE TABLE [dbo].[DefaultRoleAudit] (
    [pk]             DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME      NULL,
    [AuditEndDate]   DATETIME      NULL,
    [AuditUser]      VARCHAR (50)  NULL,
    [AuditMachine]   VARCHAR (15)  NULL,
    [AuditDeleted]   TINYINT       NULL,
    [pkDefaultRole]  DECIMAL (18)  NOT NULL,
    [RoleName]       VARCHAR (50)  NULL,
    [Description]    VARCHAR (100) NULL,
    CONSTRAINT [PK_DefaultRoleAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkDefaultRoleAudit]
    ON [dbo].[DefaultRoleAudit]([pkDefaultRole] ASC);

