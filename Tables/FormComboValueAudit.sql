CREATE TABLE [dbo].[FormComboValueAudit] (
    [pk]               DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]   DATETIME      NULL,
    [AuditEndDate]     DATETIME      NULL,
    [AuditUser]        VARCHAR (50)  NULL,
    [AuditMachine]     VARCHAR (15)  NULL,
    [AuditDeleted]     TINYINT       NULL,
    [pkFormComboValue] DECIMAL (18)  NOT NULL,
    [ComboValue]       VARCHAR (255) NULL,
    CONSTRAINT [PK_FormComboValueAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormComboValueAudit]
    ON [dbo].[FormComboValueAudit]([pkFormComboValue] ASC);

