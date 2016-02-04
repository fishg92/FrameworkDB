CREATE TABLE [dbo].[JoinrefRoleProfileAudit] (
    [pk]                   DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]       DATETIME     NULL,
    [AuditEndDate]         DATETIME     NULL,
    [AuditUser]            VARCHAR (50) NULL,
    [AuditMachine]         VARCHAR (15) NULL,
    [AuditDeleted]         TINYINT      NULL,
    [pkJoinrefRoleProfile] DECIMAL (18) NOT NULL,
    [fkrefRole]            DECIMAL (18) NOT NULL,
    [fkProfile]            DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinrefRoleProfileAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinrefRoleProfileAudit]
    ON [dbo].[JoinrefRoleProfileAudit]([pkJoinrefRoleProfile] ASC);

