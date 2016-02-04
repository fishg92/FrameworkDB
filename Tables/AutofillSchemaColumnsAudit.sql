CREATE TABLE [dbo].[AutofillSchemaColumnsAudit] (
    [pk]                      DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]          DATETIME      NULL,
    [AuditEndDate]            DATETIME      NULL,
    [AuditUser]               VARCHAR (50)  NULL,
    [AuditMachine]            VARCHAR (15)  NULL,
    [AuditDeleted]            TINYINT       NULL,
    [pkAutofillSchemaColumns] DECIMAL (18)  NOT NULL,
    [fkAutofillSchema]        DECIMAL (18)  NOT NULL,
    [fieldName]               VARCHAR (150) NULL,
    [fieldOrder]              INT           NOT NULL,
    [CompassPeopleField]      VARCHAR (50)  CONSTRAINT [DF_AutofillSchemaColumnsAudit_CompassPeopleField] DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_AutofillSchemaColumnsAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkAutofillSchemaColumnsAudit]
    ON [dbo].[AutofillSchemaColumnsAudit]([pkAutofillSchemaColumns] ASC);

