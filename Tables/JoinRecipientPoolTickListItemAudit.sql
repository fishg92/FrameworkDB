CREATE TABLE [dbo].[JoinRecipientPoolTickListItemAudit] (
    [pk]                              DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                  DATETIME     NULL,
    [AuditEndDate]                    DATETIME     NULL,
    [AuditUser]                       VARCHAR (50) NULL,
    [AuditEffectiveUser]              VARCHAR (50) NULL,
    [AuditEffectiveDate]              DATETIME     NULL,
    [AuditMachine]                    VARCHAR (15) NULL,
    [AuditDeleted]                    TINYINT      NULL,
    [pkJoinRecipientPoolTickListItem] DECIMAL (18) NOT NULL,
    [fkRecipientPool]                 DECIMAL (18) NOT NULL,
    [fkApplicationUser]               DECIMAL (18) NOT NULL,
    [TickListIndex]                   INT          NOT NULL,
    [Selected]                        BIT          DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_JoinRecipientPoolTickListItemAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinRecipientPoolTickListItemAudit]
    ON [dbo].[JoinRecipientPoolTickListItemAudit]([pkJoinRecipientPoolTickListItem] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Marks this item as the last one selected', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinRecipientPoolTickListItemAudit', @level2type = N'COLUMN', @level2name = N'Selected';

