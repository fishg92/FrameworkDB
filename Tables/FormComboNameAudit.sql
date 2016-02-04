CREATE TABLE [dbo].[FormComboNameAudit] (
    [pk]              DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]  DATETIME     NULL,
    [AuditEndDate]    DATETIME     NULL,
    [AuditUser]       VARCHAR (50) NULL,
    [AuditMachine]    VARCHAR (15) NULL,
    [AuditDeleted]    TINYINT      NULL,
    [pkFormComboName] DECIMAL (18) NOT NULL,
    [ComboName]       VARCHAR (50) NULL,
    CONSTRAINT [PK_FormComboNameAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormComboNameAudit]
    ON [dbo].[FormComboNameAudit]([pkFormComboName] ASC);

