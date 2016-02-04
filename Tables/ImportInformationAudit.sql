CREATE TABLE [dbo].[ImportInformationAudit] (
    [pk]                             DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                 DATETIME     NULL,
    [AuditEndDate]                   DATETIME     NULL,
    [AuditUser]                      VARCHAR (50) NULL,
    [AuditMachine]                   VARCHAR (15) NULL,
    [AuditDeleted]                   TINYINT      NULL,
    [pkImportInformation]            DECIMAL (18) NOT NULL,
    [Deleted]                        BIT          NULL,
    [EffectiveUser]                  VARCHAR (50) NULL,
    [EffectiveDate]                  DATETIME     NULL,
    [CaseLoad]                       VARCHAR (50) NULL,
    [CaseNumber]                     VARCHAR (50) NULL,
    [LastImportDate]                 DATETIME     NULL,
    [ForceUpdate]                    TINYINT      NULL,
    [MedicaidOnly]                   TINYINT      NULL,
    [Suspect]                        BIT          NULL,
    [IQCPLastDate]                   DATETIME     NULL,
    [IQCPScheduleDate]               DATETIME     NULL,
    [IQCPDueDate]                    DATETIME     NULL,
    [CaseNumberValidatedForCaseLoad] TINYINT      NULL,
    CONSTRAINT [PK_ImportInformationAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkImportInformationAudit]
    ON [dbo].[ImportInformationAudit]([pkImportInformation] ASC);

