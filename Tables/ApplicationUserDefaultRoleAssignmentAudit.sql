CREATE TABLE [dbo].[ApplicationUserDefaultRoleAssignmentAudit] (
    [pk]                                     DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                         DATETIME     NULL,
    [AuditEndDate]                           DATETIME     NULL,
    [AuditUser]                              VARCHAR (50) NULL,
    [AuditMachine]                           VARCHAR (15) NULL,
    [AuditDeleted]                           TINYINT      NULL,
    [pkApplicationUserDefaultRoleAssignment] DECIMAL (18) NOT NULL,
    [fkApplicationUser]                      DECIMAL (18) NOT NULL,
    [fkDefaultRole]                          DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_ApplicationUserDefaultRoleAssignmentAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkApplicationUserDefaultRoleAssignmentAudit]
    ON [dbo].[ApplicationUserDefaultRoleAssignmentAudit]([pkApplicationUserDefaultRoleAssignment] ASC);

