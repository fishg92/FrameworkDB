CREATE TABLE [dbo].[AutofillSchemaDataStoreAttributeAudit] (
    [pk]                                 DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                     DATETIME      NULL,
    [AuditEndDate]                       DATETIME      NULL,
    [AuditUser]                          VARCHAR (50)  NULL,
    [AuditMachine]                       VARCHAR (15)  NULL,
    [AuditDeleted]                       TINYINT       NULL,
    [pkAutofillSchemaDataStoreAttribute] DECIMAL (18)  NOT NULL,
    [fkAutofillSchemaDataStore]          DECIMAL (18)  NOT NULL,
    [ItemKey]                            VARCHAR (100) NULL,
    [ItemValue]                          VARCHAR (500) NULL,
    CONSTRAINT [PK_AutofillSchemaDataStoreAttributeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkAutofillSchemaDataStoreAttributeAudit]
    ON [dbo].[AutofillSchemaDataStoreAttributeAudit]([pkAutofillSchemaDataStoreAttribute] ASC);

