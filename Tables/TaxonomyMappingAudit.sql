CREATE TABLE [dbo].[TaxonomyMappingAudit] (
    [pk]                 DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]     DATETIME      NULL,
    [AuditEndDate]       DATETIME      NULL,
    [AuditUser]          VARCHAR (50)  NULL,
    [AuditEffectiveUser] VARCHAR (50)  NULL,
    [AuditEffectiveDate] DATETIME      NULL,
    [AuditMachine]       VARCHAR (15)  NULL,
    [AuditDeleted]       TINYINT       NULL,
    [pkTaxonomyMapping]  DECIMAL (18)  NOT NULL,
    [DocTypeID]          VARCHAR (50)  NULL,
    [DocType]            VARCHAR (100) NULL,
    [DocTypeGroup]       VARCHAR (100) NULL,
    [DocExamples]        VARCHAR (MAX) NULL,
    CONSTRAINT [PK_TaxonomyMappingAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkTaxonomyMappingAudit]
    ON [dbo].[TaxonomyMappingAudit]([pkTaxonomyMapping] ASC);

