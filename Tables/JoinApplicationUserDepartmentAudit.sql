CREATE TABLE [dbo].[JoinApplicationUserDepartmentAudit] (
    [pk]                              DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                  DATETIME     NULL,
    [AuditEndDate]                    DATETIME     NULL,
    [AuditUser]                       VARCHAR (50) NULL,
    [AuditMachine]                    VARCHAR (15) NULL,
    [AuditDeleted]                    TINYINT      NULL,
    [pkJoinApplicationUserDepartment] DECIMAL (18) NOT NULL,
    [fkApplicationUser]               DECIMAL (18) NOT NULL,
    [fkDepartment]                    DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinApplicationUserDepartmentAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinApplicationUserDepartmentAudit]
    ON [dbo].[JoinApplicationUserDepartmentAudit]([pkJoinApplicationUserDepartment] ASC);

