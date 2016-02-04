CREATE TABLE [dbo].[JoinDefaultRolerefPermissionAudit] (
    [pk]                             DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                 DATETIME     NULL,
    [AuditEndDate]                   DATETIME     NULL,
    [AuditUser]                      VARCHAR (50) NULL,
    [AuditMachine]                   VARCHAR (15) NULL,
    [AuditDeleted]                   TINYINT      NULL,
    [pkJoinDefaultRolerefPermission] DECIMAL (18) NOT NULL,
    [fkDefaultRole]                  DECIMAL (18) NOT NULL,
    [fkrefPermission]                DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinDefaultRolerefPermissionAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinDefaultRolerefPermissionAudit]
    ON [dbo].[JoinDefaultRolerefPermissionAudit]([pkJoinDefaultRolerefPermission] ASC);

