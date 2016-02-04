CREATE TABLE [dbo].[JoinApplicationUserProgramTypeAudit] (
    [pk]                               DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                   DATETIME     NULL,
    [AuditEndDate]                     DATETIME     NULL,
    [AuditUser]                        VARCHAR (50) NULL,
    [AuditMachine]                     VARCHAR (15) NULL,
    [AuditDeleted]                     TINYINT      NULL,
    [pkJoinApplicationUserProgramType] DECIMAL (18) NOT NULL,
    [fkApplicationUser]                DECIMAL (18) NOT NULL,
    [fkProgramType]                    DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinApplicationUserProgramTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinApplicationUserProgramTypeAudit]
    ON [dbo].[JoinApplicationUserProgramTypeAudit]([pkJoinApplicationUserProgramType] ASC);

