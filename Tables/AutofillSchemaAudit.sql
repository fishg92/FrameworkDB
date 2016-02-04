CREATE TABLE [dbo].[AutofillSchemaAudit] (
    [pk]                        DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]            DATETIME      NULL,
    [AuditEndDate]              DATETIME      NULL,
    [AuditUser]                 VARCHAR (50)  NULL,
    [AuditMachine]              VARCHAR (15)  NULL,
    [AuditDeleted]              TINYINT       NULL,
    [pkAutofillSchema]          DECIMAL (18)  NOT NULL,
    [queryText]                 VARCHAR (MAX) NULL,
    [friendlyName]              VARCHAR (150) NULL,
    [fkAutofillSchemaDataStore] DECIMAL (18)  NULL,
    CONSTRAINT [PK_AutofillSchemaAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkAutofillSchemaAudit]
    ON [dbo].[AutofillSchemaAudit]([pkAutofillSchema] ASC);

