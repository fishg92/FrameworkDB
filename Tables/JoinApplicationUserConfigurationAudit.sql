CREATE TABLE [dbo].[JoinApplicationUserConfigurationAudit] (
    [pk]                                 DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                     DATETIME     NULL,
    [AuditEndDate]                       DATETIME     NULL,
    [AuditUser]                          VARCHAR (50) NULL,
    [AuditMachine]                       VARCHAR (15) NULL,
    [AuditDeleted]                       TINYINT      NULL,
    [pkJoinApplicationUserConfiguration] DECIMAL (18) NOT NULL,
    [fkApplicationUser]                  DECIMAL (18) NOT NULL,
    [fkConfiguration]                    DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinApplicationUserConfigurationAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinApplicationUserConfigurationAudit]
    ON [dbo].[JoinApplicationUserConfigurationAudit]([pkJoinApplicationUserConfiguration] ASC);

