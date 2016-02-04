CREATE TABLE [dbo].[AutofillSchemaDataViewAudit] (
    [pk]                          DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]              DATETIME      NULL,
    [AuditEndDate]                DATETIME      NULL,
    [AuditUser]                   VARCHAR (50)  NULL,
    [AuditMachine]                VARCHAR (15)  NULL,
    [AuditDeleted]                TINYINT       NULL,
    [pkAutofillSchemaDataView]    DECIMAL (18)  NOT NULL,
    [fkAutofillSchema]            DECIMAL (18)  NOT NULL,
    [FriendlyName]                VARCHAR (150) NULL,
    [IgnoreProgramTypeSecurity]   TINYINT       NOT NULL,
    [IgnoreSecuredClientSecurity] TINYINT       NOT NULL,
    CONSTRAINT [PK_AutofillSchemaDataViewAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkAutofillSchemaDataViewAudit]
    ON [dbo].[AutofillSchemaDataViewAudit]([pkAutofillSchemaDataView] ASC);

