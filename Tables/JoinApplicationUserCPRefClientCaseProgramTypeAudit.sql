CREATE TABLE [dbo].[JoinApplicationUserCPRefClientCaseProgramTypeAudit] (
    [pk]                                              DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                                  DATETIME     NULL,
    [AuditEndDate]                                    DATETIME     NULL,
    [AuditUser]                                       VARCHAR (50) NULL,
    [AuditMachine]                                    VARCHAR (15) NULL,
    [AuditDeleted]                                    TINYINT      NULL,
    [pkJoinApplicationUserCPRefClientCaseProgramType] DECIMAL (18) NOT NULL,
    [fkApplicationUser]                               DECIMAL (18) NOT NULL,
    [fkCPRefClientCaseProgramType]                    DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinApplicationUserCPRefClientCaseProgramTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinApplicationUserCPRefClientCaseProgramTypeAudit]
    ON [dbo].[JoinApplicationUserCPRefClientCaseProgramTypeAudit]([pkJoinApplicationUserCPRefClientCaseProgramType] ASC);

