CREATE TABLE [dbo].[JoinRecipientPoolMemberAudit] (
    [pk]                        DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]            DATETIME     NULL,
    [AuditEndDate]              DATETIME     NULL,
    [AuditUser]                 VARCHAR (50) NULL,
    [AuditEffectiveUser]        VARCHAR (50) NULL,
    [AuditEffectiveDate]        DATETIME     NULL,
    [AuditMachine]              VARCHAR (15) NULL,
    [AuditDeleted]              TINYINT      NULL,
    [pkJoinRecipientPoolMember] DECIMAL (18) NOT NULL,
    [fkRecipientPool]           DECIMAL (18) NOT NULL,
    [fkApplicationUser]         DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinRecipientPoolMemberAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinRecipientPoolMemberAudit]
    ON [dbo].[JoinRecipientPoolMemberAudit]([pkJoinRecipientPoolMember] ASC);

