CREATE TABLE [dbo].[AutofillSchemaDataViewColumnsAudit] (
    [pk]                              DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                  DATETIME      NULL,
    [AuditEndDate]                    DATETIME      NULL,
    [AuditUser]                       VARCHAR (50)  NULL,
    [AuditMachine]                    VARCHAR (15)  NULL,
    [AuditDeleted]                    TINYINT       NULL,
    [pkAutofillSchemaDataViewColumns] DECIMAL (18)  NOT NULL,
    [fkAutofillSchemaColumns]         DECIMAL (18)  NOT NULL,
    [fkAutofillSchemaDataView]        DECIMAL (18)  NOT NULL,
    [FriendlyName]                    VARCHAR (150) NULL,
    [Visible]                         TINYINT       NOT NULL,
    [SortOrder]                       INT           NOT NULL,
    [IsUniqueID]                      TINYINT       CONSTRAINT [DF__AutofillS__IsUni__4B304998] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_AutofillSchemaDataViewColumnsAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkAutofillSchemaDataViewColumnsAudit]
    ON [dbo].[AutofillSchemaDataViewColumnsAudit]([pkAutofillSchemaDataViewColumns] ASC);

