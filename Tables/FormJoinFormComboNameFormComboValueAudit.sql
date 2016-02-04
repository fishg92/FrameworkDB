CREATE TABLE [dbo].[FormJoinFormComboNameFormComboValueAudit] (
    [pk]                                    DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                        DATETIME     NULL,
    [AuditEndDate]                          DATETIME     NULL,
    [AuditUser]                             VARCHAR (50) NULL,
    [AuditMachine]                          VARCHAR (15) NULL,
    [AuditDeleted]                          TINYINT      NULL,
    [pkFormJoinFormComboNameFormComboValue] DECIMAL (18) NOT NULL,
    [fkFormComboName]                       DECIMAL (18) NOT NULL,
    [fkFormComboValue]                      DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_FormJoinFormComboNameFormComboValueAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormJoinFormComboNameFormComboValueAudit]
    ON [dbo].[FormJoinFormComboNameFormComboValueAudit]([pkFormJoinFormComboNameFormComboValue] ASC);

