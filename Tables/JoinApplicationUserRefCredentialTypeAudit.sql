CREATE TABLE [dbo].[JoinApplicationUserRefCredentialTypeAudit] (
    [pk]                                     DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                         DATETIME      NULL,
    [AuditEndDate]                           DATETIME      NULL,
    [AuditUser]                              VARCHAR (50)  NULL,
    [AuditMac]                               CHAR (17)     NULL,
    [AuditIP]                                VARCHAR (15)  NULL,
    [AuditMachine]                           VARCHAR (15)  NULL,
    [AuditDeleted]                           TINYINT       NULL,
    [pkJoinApplicationUserRefCredentialType] DECIMAL (18)  NOT NULL,
    [fkApplicationUser]                      DECIMAL (18)  NOT NULL,
    [fkRefCredentialType]                    DECIMAL (18)  NOT NULL,
    [UserName]                               VARCHAR (50)  NULL,
    [Password]                               VARCHAR (200) NULL,
    CONSTRAINT [PK_JoinApplicationUserRefCredentialTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinApplicationUserRefCredentialTypeAudit]
    ON [dbo].[JoinApplicationUserRefCredentialTypeAudit]([pkJoinApplicationUserRefCredentialType] ASC);

