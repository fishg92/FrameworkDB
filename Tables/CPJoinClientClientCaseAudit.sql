CREATE TABLE [dbo].[CPJoinClientClientCaseAudit] (
    [pk]                            DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                DATETIME     NULL,
    [AuditEndDate]                  DATETIME     NULL,
    [AuditUser]                     VARCHAR (50) NULL,
    [AuditMachine]                  VARCHAR (15) NULL,
    [AuditDeleted]                  TINYINT      NULL,
    [pkCPJoinClientClientCase]      DECIMAL (18) NOT NULL,
    [fkCPClientCase]                DECIMAL (18) NULL,
    [fkCPClient]                    DECIMAL (18) NULL,
    [PrimaryParticipantOnCase]      TINYINT      NULL,
    [fkCPRefClientRelationshipType] DECIMAL (18) NULL,
    [LockedUser]                    VARCHAR (50) NULL,
    [LockedDate]                    DATETIME     NULL,
    CONSTRAINT [PK_CPJoinClientClientCaseAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxfkCpClientCase]
    ON [dbo].[CPJoinClientClientCaseAudit]([fkCPClientCase] ASC, [AuditDeleted] ASC);


GO
CREATE NONCLUSTERED INDEX [idxpktoCPClienttoCPClientCase]
    ON [dbo].[CPJoinClientClientCaseAudit]([pkCPJoinClientClientCase] ASC, [fkCPClient] ASC, [fkCPClientCase] ASC)
    INCLUDE([AuditDeleted]);

