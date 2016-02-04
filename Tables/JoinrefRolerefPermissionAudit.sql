CREATE TABLE [dbo].[JoinrefRolerefPermissionAudit] (
    [pk]                         DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]             DATETIME     NULL,
    [AuditEndDate]               DATETIME     NULL,
    [AuditUser]                  VARCHAR (50) NULL,
    [AuditMachine]               VARCHAR (15) NULL,
    [AuditDeleted]               TINYINT      NULL,
    [pkJoinrefRolerefPermission] DECIMAL (18) NOT NULL,
    [fkrefRole]                  DECIMAL (18) NOT NULL,
    [fkrefPermission]            DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinrefRolerefPermissionAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinrefRolerefPermissionAudit]
    ON [dbo].[JoinrefRolerefPermissionAudit]([pkJoinrefRolerefPermission] ASC);

