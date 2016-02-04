CREATE TABLE [dbo].[JoinApplicationUserrefRoleAudit] (
    [pk]                           DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]               DATETIME     NULL,
    [AuditEndDate]                 DATETIME     NULL,
    [AuditUser]                    VARCHAR (50) NULL,
    [AuditMachine]                 VARCHAR (15) NULL,
    [AuditDeleted]                 TINYINT      NULL,
    [pkJoinApplicationUserrefRole] DECIMAL (18) NOT NULL,
    [fkApplicationUser]            DECIMAL (18) NOT NULL,
    [fkrefRole]                    DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinApplicationUserrefRoleAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinApplicationUserrefRoleAudit]
    ON [dbo].[JoinApplicationUserrefRoleAudit]([pkJoinApplicationUserrefRole] ASC);

