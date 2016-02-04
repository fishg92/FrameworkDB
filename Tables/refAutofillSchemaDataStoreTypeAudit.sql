CREATE TABLE [dbo].[refAutofillSchemaDataStoreTypeAudit] (
    [pk]                               DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                   DATETIME      NULL,
    [AuditEndDate]                     DATETIME      NULL,
    [AuditUser]                        VARCHAR (50)  NULL,
    [AuditMachine]                     VARCHAR (15)  NULL,
    [AuditDeleted]                     TINYINT       NULL,
    [pkrefAutofillSchemaDataStoreType] DECIMAL (18)  NOT NULL,
    [FriendlyName]                     VARCHAR (150) NULL,
    CONSTRAINT [PK_refAutofillSchemaDataStoreTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkrefAutofillSchemaDataStoreTypeAudit]
    ON [dbo].[refAutofillSchemaDataStoreTypeAudit]([pkrefAutofillSchemaDataStoreType] ASC);

