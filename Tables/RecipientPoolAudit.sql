CREATE TABLE [dbo].[RecipientPoolAudit] (
    [pk]                        DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]            DATETIME      NULL,
    [AuditEndDate]              DATETIME      NULL,
    [AuditUser]                 VARCHAR (50)  NULL,
    [AuditEffectiveUser]        VARCHAR (50)  NULL,
    [AuditEffectiveDate]        DATETIME      NULL,
    [AuditMachine]              VARCHAR (15)  NULL,
    [AuditDeleted]              TINYINT       NULL,
    [pkRecipientPool]           DECIMAL (18)  NOT NULL,
    [Name]                      VARCHAR (100) NULL,
    [PreviousTickListIndexUsed] INT           CONSTRAINT [DF__Recipient__Previ__7C87AE0A] DEFAULT ((-1)) NOT NULL,
    [LockDate]                  DATETIME      NULL,
    [fkLockApplicationUser]     DECIMAL (18)  NULL,
    CONSTRAINT [PK_RecipientPoolAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkRecipientPoolAudit]
    ON [dbo].[RecipientPoolAudit]([pkRecipientPool] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'the date the pool was locked', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RecipientPoolAudit', @level2type = N'COLUMN', @level2name = N'LockDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'the pk of the user who locked it', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RecipientPoolAudit', @level2type = N'COLUMN', @level2name = N'fkLockApplicationUser';

