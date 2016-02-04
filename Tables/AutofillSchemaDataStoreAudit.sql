CREATE TABLE [dbo].[AutofillSchemaDataStoreAudit] (
    [pk]                                DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                    DATETIME      NULL,
    [AuditEndDate]                      DATETIME      NULL,
    [AuditUser]                         VARCHAR (50)  NULL,
    [AuditMachine]                      VARCHAR (15)  NULL,
    [AuditDeleted]                      TINYINT       NULL,
    [pkAutofillSchemaDataStore]         DECIMAL (18)  NOT NULL,
    [FriendlyName]                      VARCHAR (200) NULL,
    [fkrefAutofillSchemaDataSourceType] DECIMAL (18)  NOT NULL,
    CONSTRAINT [PK_AutofillSchemaDataStoreAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkAutofillSchemaDataStoreAudit]
    ON [dbo].[AutofillSchemaDataStoreAudit]([pkAutofillSchemaDataStore] ASC);

